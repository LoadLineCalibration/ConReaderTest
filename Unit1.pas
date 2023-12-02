unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, winapi.ActiveX;

type
  TForm1 = class(TForm)
    mmo1: TMemo;
    btnLoadTestFile: TButton;
    Button1: TButton;
    Button2: TButton;
    btnExit: TButton;

    procedure LoadConFile(filename: string);
    procedure btnLoadTestFileClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnExitClick(Sender: TObject);
begin
    Application.Terminate();
end;

procedure TForm1.btnLoadTestFileClick(Sender: TObject);
begin
    LoadConFile('C:\LANG\DelphiProjects\ConvEditor\TestConFile.con');
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
    LoadConFile('C:\LANG\DelphiProjects\ConvEditor\AiBarks.con');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    LoadConFile('C:\LANG\DelphiProjects\ConvEditor\Minimal.con');
end;

procedure TForm1.LoadConFile(filename: string);
var
  fileStr: TFileStream;
  BinRead: TBinaryReader;
  missionsArray: array of Integer;
  convosArray: array of string;
begin
    mmo1.Clear();

    fileStr:= TFileStream.Create(filename, fmOpenRead);
    BinRead:= TBinaryReader.Create(fileStr, TEncoding.ANSI, False);

    try
      mmo1.Lines.Add('Load file: ' + filename + #13#10);

      var HeaderBytes := BinRead.ReadBytes(26);
      var HeaderStr :=  TEncoding.ANSI.GetString(HeaderBytes);
      mmo1.Lines.Add(HeaderStr);

      var conVersion := BinRead.ReadInt32();
      mmo1.Lines.Add('Version: ' + conVersion.ToString);

      var CreatedOnTime := BinRead.ReadDouble();
      mmo1.Lines.Add('CreatedOnTime: ' + CreatedOnTime.ToString);

      var CreatedByStrSize:= BinRead.ReadInt32();
      mmo1.Lines.Add(#13#10 + 'CreatedBySize: ' + CreatedByStrSize.ToString);

      var CreatedByBytes := BinRead.ReadBytes(CreatedByStrSize);
      mmo1.Lines.Add('CreatedBy: ' + TEncoding.ANSI.GetString(CreatedByBytes) + #13#10);


      var LastModifOn:= BinRead.ReadDouble();
      mmo1.Lines.Add('LastModifiedOn: ' + LastModifOn.ToString);


      var LastModifBySize:= BinRead.ReadInt32(); // Прочесть размер строки
      mmo1.Lines.Add('LastModifBySize: ' + LastModifBySize.ToString);

      var LastModifByBytes := BinRead.ReadBytes(LastModifBySize); // Прочесть исходя из ранее полученных данных
      mmo1.Lines.Add('ModifBy: ' + TEncoding.ANSI.GetString(LastModifByBytes) + #13#10);

      // audio package
      var audioPackStrSize := BinRead.ReadInt32();
      mmo1.Lines.Add('audioPackStrSize: ' + audioPackStrSize.ToString);

      var audioPackStrBytes := BinRead.ReadBytes(audioPackStrSize);
      mmo1.Lines.Add('audioPackStr:' + TEncoding.ANSI.GetString(audioPackStrBytes) + #13#10);

      // notes
      var notesSize:= BinRead.ReadInt32();
      mmo1.Lines.Add('notesSize: ' + notesSize.ToString);

      var notesStrBytes:= BinRead.ReadBytes(notesSize);
      mmo1.Lines.Add('NotesStr: ' + TEncoding.ANSI.GetString(notesStrBytes) + #13#10);

      // Used Missions
      var numMissionList := BinRead.ReadInt32();
      mmo1.Lines.Add('numMissionList: ' + numMissionList.ToString);

      // массив из Integer?
      SetLength(missionsArray, numMissionList);
      for var i := 0 to numMissionList -1 do begin
         missionsArray[i] := BinRead.ReadInt32();
         mmo1.Lines.Add('Used Missions: ' + missionsArray[i].ToString);
      end;

      // stats (и как это работает? Строка разделённая нулями?)
      var statsSize:= BinRead.ReadInt32();
      var statsStrBytes := BinRead.ReadBytes(statsSize);
      mmo1.Lines.Add('stats: ' + TEncoding.ANSI.GetString(statsStrBytes) + ' size: ' + statsSize.ToString + #13#10);

      var unknownField4 := BinRead.ReadInt32();
      mmo1.Lines.Add('unknown4: ' + unknownField4.ToString);

      var numConversations := BinRead.ReadInt32();
      mmo1.Lines.Add('numConversations: ' + numConversations.ToString);

      mmo1.Lines.Add('--==[ Conversations: ]==--');

      for var nc := 0 to numConversations -1 do begin
          var unknown0 := BinRead.ReadInt32(); // unknown0
          mmo1.Lines.Add(#13#10 + 'unknown0: ' + unknown0.ToString);

          var convId:= BinRead.ReadInt32(); // conversation id
          mmo1.Lines.Add('id: ' + convId.ToString);

          var convNameSize:= BinRead.ReadInt32(); // conversation name size
          var convNameBytes:= BinRead.ReadBytes(convNameSize); // name
          mmo1.Lines.Add('convName: ' + TEncoding.ANSI.GetString(convNameBytes));


          var convDescSize:= BinRead.ReadInt32();
          var convDescBytes := BinRead.ReadBytes(convDescSize);
          mmo1.Lines.Add('convDesc: ' + TEncoding.ANSI.GetString(convDescBytes));


          var CreatedOnConv := BinRead.ReadDouble();
          mmo1.Lines.Add('CreatedOnConv: ' + CreatedOnConv.ToString);

          var CreatedByConvSize := BinRead.ReadInt32();
          var CreatedByConvBytes := BinRead.ReadBytes(CreatedByConvSize);
          mmo1.Lines.Add('createdByConv: ' + TEncoding.ANSI.GetString(CreatedByConvBytes));


          var LastModifOnConv := BinRead.ReadDouble();
          mmo1.Lines.Add('LastModifOnConv: ' + LastModifOnConv.ToString);

          var LastModifByConvSize := BinRead.ReadInt32();
          var lastModifByConvBytes := BinRead.ReadBytes(LastModifByConvSize);
          mmo1.Lines.Add('LastModifBy: ' + TEncoding.ANSI.GetString(lastModifByConvBytes));


          var conOwnerNameId := BinRead.ReadInt32();
          mmo1.Lines.Add('conOwnerNameId: ' + conOwnerNameId.ToString);

          var conOwnerNameSize:= BinRead.ReadInt32();
          var conOwnerNameBytes := BinRead.ReadBytes(conOwnerNameSize);
          mmo1.Lines.Add('conOwnerName: ' + TEncoding.ANSI.GetString(conOwnerNameBytes));

          // conversation parameters...
          var bDataLinkCon := BinRead.ReadInt32();
          mmo1.Lines.Add('bDataLinkCon: ' + bDataLinkCon.ToString + ' (' + BoolToStr(bDataLinkCon.ToBoolean, True) + ')');

          // conversation notes
          var conNotesSize:= BinRead.ReadInt32();
          var conNotesBytes:= BinRead.ReadBytes(conNotesSize);
          mmo1.Lines.Add('conNotesSize: ' + conNotesSize.ToString + ' conNotes: ' + TEncoding.ANSI.GetString(conNotesBytes));

          // conversation parameters... continued
          var bDisplayOnce:= BinRead.ReadInt32();
          mmo1.Lines.Add('bDisplayOnce: ' + bDisplayOnce.ToString + ' (' + BoolToStr(bDisplayOnce.ToBoolean, True) + ')');

          var bFirstPerson := BinRead.ReadInt32();
          mmo1.Lines.Add('bFirstPerson: ' + bFirstPerson.ToString + ' (' + BoolToStr(bFirstPerson.ToBoolean, True) + ')');

          var bNonInteractive:= BinRead.ReadInt32();
          mmo1.Lines.Add('bNonInteractive: ' + bNonInteractive.ToString + ' (' + BoolToStr(bNonInteractive.ToBoolean, True) + ')');

          var bRandomCamera := BinRead.ReadInt32();
          mmo1.Lines.Add('bRandomCamera: ' + bRandomCamera.ToString + ' (' + BoolToStr(bRandomCamera.ToBoolean, True) + ')');

          var bCanBeInterrupted:= BinRead.ReadInt32();
          mmo1.Lines.Add('bCanBeInterrupted: ' + bCanBeInterrupted.ToString + ' (' + BoolToStr(bCanBeInterrupted.ToBoolean, True) + ')');

          var bCannotBeInterrupted := BinRead.ReadInt32();
          mmo1.Lines.Add('bCannotBeInterrupted: ' + bCannotBeInterrupted.ToString + ' (' + BoolToStr(bCannotBeInterrupted.ToBoolean, True) + ')');

          var bInvokeBump:= BinRead.ReadInt32();
          mmo1.Lines.Add('bInvokeBump: ' + bInvokeBump.ToString + ' (' + BoolToStr(bInvokeBump.ToBoolean, True) + ')');

          var bInvokeFrob := BinRead.ReadInt32();
          mmo1.Lines.Add('bInvokeFrob: ' + bInvokeFrob.ToString + ' (' + BoolToStr(bInvokeFrob.ToBoolean, True) + ')');

          var bInvokeSight:= BinRead.ReadInt32();
          mmo1.Lines.Add('bInvokeSight: ' + bInvokeSight.ToString + ' (' + BoolToStr(bInvokeSight.ToBoolean, True) + ')');

          var bInvokeRadius:= BinRead.ReadInt32();
          mmo1.Lines.Add('bInvokeRadius: ' + bInvokeRadius.ToString + ' (' + BoolToStr(bInvokeRadius.ToBoolean, True) + ')');

          var InvokeRadius:= BinRead.ReadInt32();
          mmo1.Lines.Add('InvokeRadius: ' + InvokeRadius.ToString);

          var numFlagRefList:= BinRead.ReadInt32();
          mmo1.Lines.Add(#13#10 + 'numFlagRefList: ' + numFlagRefList.ToString);

            for var fr:=0 to numFlagRefList -1 do
            begin
                var flagRefId:= BinRead.ReadInt32();
                var flagRefNameSize:= BinRead.ReadInt32();
                var flagRefNameBytes:= BinRead.ReadBytes(flagRefNameSize);
                var flagRefNameStr:= TEncoding.ANSI.GetString(flagRefNameBytes);
                var flagRefValue:= BinRead.ReadInt32();
                var flagRefExpiration := BinRead.ReadInt32();

                mmo1.Lines.Add('conFlagRef name: ' + flagRefNameStr +
                               ' conFlagRefNameSize: ' + flagRefNameSize.ToString +
                               ' conFlagRefId: ' + flagRefId.ToString +
                               ' conFlagRefValue: ' +  flagRefValue.ToString +
                               ' conFlagRefExpiration: ' +  flagRefExpiration.ToString);
            end;

          var numEventList := BinRead.ReadInt32();
          mmo1.Lines.Add('Conversation '+ TEncoding.ANSI.GetString(convNameBytes) + ' has ' + numEventList.ToString + ' events');

          // now events...








      end;

      BinRead.Close();
    finally
      BinRead.Free();
      fileStr.Free();
    end;
end;

end.
