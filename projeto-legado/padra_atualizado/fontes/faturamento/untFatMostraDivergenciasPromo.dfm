inherited frmFatMostraDivergenciasPromo: TfrmFatMostraDivergenciasPromo
  Width = 791
  Height = 311
  Caption = 'Itens com Diverg'#234'ncia de Promo'#231#245'es'
  Position = poMainFormCenter
  ExplicitWidth = 791
  ExplicitHeight = 311
  PixelsPerInch = 96
  TextHeight = 14
  object lblMSG: TLabel [0]
    Left = 0
    Top = 16
    Width = 785
    Height = 32
    Align = alTop
    Alignment = taCenter
    Caption = 
      'O pedido/or'#231'amento [COD_PED_ORC] possui itens que estavam na pro' +
      'mo'#231#227'o, que n'#227'o est'#227'o mais. O valor dos produtos ser'#227'o recalculad' +
      'os seguindo par'#226'metros de pre'#231'os atuais. Abaixo, segue a rela'#231#227'o' +
      ' dos itens que ter'#227'o altera'#231#227'o de pre'#231'o:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
    WordWrap = True
    ExplicitTop = 48
    ExplicitWidth = 711
  end
  object lblAtencao: TLabel [1]
    Left = 0
    Top = 0
    Width = 785
    Height = 16
    Align = alTop
    Alignment = taCenter
    Caption = 'ATEN'#199#195'O!'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    WordWrap = True
    ExplicitTop = 10
    ExplicitWidth = 65
  end
  inherited pnlBotoes: TPanel
    Top = 239
    Width = 785
    ExplicitTop = 239
    ExplicitWidth = 785
    inherited btnSair: TBitBtnLocked
      Left = 702
      Caption = '&Ok'
      Glyph.Data = {00000000}
      ExplicitLeft = 702
    end
  end
  inherited pnlStatus: TPanel
    Top = 267
    Width = 785
    ExplicitTop = 267
    ExplicitWidth = 785
    inherited pnlNomeForm: TPanel
      Left = 614
      ExplicitLeft = 614
    end
    inherited pnlInfo: TPanel
      Width = 614
      ExplicitWidth = 614
    end
  end
  object dbgItens: TDBGridCitel [5]
    Left = 0
    Top = 48
    Width = 785
    Height = 191
    Align = alClient
    DataSource = dtsItens
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnKeyDown = dbgItensKeyDown
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'CODITE'
        Title.Caption = 'C'#243'digo'
        Width = 39
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 470
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UNIDAD'
        Title.Caption = 'UN'
        Width = 20
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDITE'
        Title.Alignment = taRightJustify
        Title.Caption = 'QTD'
        Width = 57
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'UNICOM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vlr. Unit.'
        Width = 68
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TOTCOM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vlr. Total'
        Width = 76
        Visible = True
      end>
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 104
    Top = 192
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 104
    Top = 136
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 104
    Top = 80
  end
  object dtsItens: TDataSource
    Left = 208
    Top = 136
  end
end
