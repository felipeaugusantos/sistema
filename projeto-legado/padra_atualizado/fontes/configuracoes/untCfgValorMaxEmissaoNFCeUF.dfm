inherited frmValorMaxEmissaoNFCeUF: TfrmValorMaxEmissaoNFCeUF
  Width = 997
  Height = 694
  Caption = 'Valor m'#225'ximo para emiss'#227'o de NFC-e (Por estado)'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitTop = -110
  ExplicitWidth = 997
  ExplicitHeight = 694
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 621
    Width = 991
    ExplicitTop = 621
    ExplicitWidth = 991
    inherited FlwBotoes: TFlowPanel
      Width = 987
      ExplicitWidth = 987
    end
    inherited btnSair: TBitBtnLocked
      Left = 908
      ExplicitLeft = 908
    end
  end
  inherited pnlStatus: TPanel
    Top = 649
    Width = 991
    ExplicitTop = 649
    ExplicitWidth = 991
    inherited pnlNomeForm: TPanel
      Left = 820
      ExplicitLeft = 820
    end
    inherited pnlInfo: TPanel
      Width = 820
      ExplicitWidth = 820
    end
  end
  object dbgNFCeUF: TDBGridCitel [3]
    Left = 0
    Top = 0
    Width = 991
    Height = 621
    Align = alClient
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'NFC_ESTADO'
        ReadOnly = True
        Title.Caption = 'Estado'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NFC_DESCRI'
        ReadOnly = True
        Title.Caption = 'Descri'#231#227'o'
        Width = 350
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NFC_DESTID'
        Title.Caption = 'Destinat'#225'rio Identificado(com CPF/CNPJ)'
        Width = 230
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NFC_DESSEM'
        Title.Caption = 'Destinat'#225'rio n'#227'o Identificado(sem CPF/CNPJ)'
        Width = 230
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 176
    Top = 256
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 192
    Top = 312
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 184
    Top = 200
  end
end
