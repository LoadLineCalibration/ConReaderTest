object Form1: TForm1
  Left = 0
  Top = 0
  BorderWidth = 1
  Caption = 'Deus Ex .con file reader test'
  ClientHeight = 509
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  StyleName = 'Windows'
  DesignSize = (
    672
    509)
  TextHeight = 15
  object mmo1: TMemo
    Left = 0
    Top = 8
    Width = 669
    Height = 427
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Cascadia Code'
    Font.Style = []
    Lines.Strings = (
      'mmo1')
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
    StyleName = 'Windows'
  end
  object btnLoadTestFile: TButton
    Left = 0
    Top = 476
    Width = 297
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C:\LANG\DelphiProjects\ConvEditor\TestConFile.con'
    TabOrder = 1
    OnClick = btnLoadTestFileClick
  end
  object Button1: TButton
    Left = 0
    Top = 441
    Width = 297
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C:\LANG\DelphiProjects\ConvEditor\AiBarks.con'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 303
    Top = 441
    Width = 297
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'C:\LANG\DelphiProjects\ConvEditor\Minimal.con'
    TabOrder = 3
    OnClick = Button2Click
  end
  object btnExit: TButton
    Left = 601
    Top = 476
    Width = 63
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'btnExit'
    TabOrder = 4
    StyleName = 'Windows'
    OnClick = btnExitClick
  end
end
