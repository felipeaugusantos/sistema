object frmAlterarNCMTintas: TfrmAlterarNCMTintas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSizeToolWin
  Caption = 'Alterar NCM das Tintas'
  ClientHeight = 374
  ClientWidth = 575
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object dbgItens: TDBGrid
    Left = 0
    Top = 0
    Width = 575
    Height = 345
    Align = alClient
    DataSource = dtsItens
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'DET_CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DET_DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 358
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TRI_NCMTIN'
        Title.Caption = 'C'#243'digo NCM'
        Width = 91
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 345
    Width = 575
    Height = 29
    Align = alBottom
    Caption = '[ENTER] Informar um novo NCM'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
  object dtsItens: TDataSource
    Left = 224
    Top = 96
  end
end
