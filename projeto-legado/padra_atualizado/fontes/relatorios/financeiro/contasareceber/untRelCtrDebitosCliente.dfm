inherited frmRelCtrDebitosCliente: TfrmRelCtrDebitosCliente
  Left = 371
  Top = 310
  Width = 351
  Height = 210
  Caption = 'Relat'#243'rio de D'#233'bitos'
  ExplicitWidth = 351
  ExplicitHeight = 210
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 139
    Width = 345
    ExplicitTop = 147
    ExplicitWidth = 345
    inherited FlwBotoes: TFlowPanel
      Width = 264
      Align = alLeft
      ExplicitWidth = 264
      inherited btnImprimir: TBitBtnLocked
        Align = alLeft
        Caption = '&Gerar'
        ModalResult = 1
      end
      inherited btnConfigurar: TBitBtnLocked
        Align = alLeft
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 266
      ModalResult = 2
      ExplicitLeft = 266
    end
  end
  inherited pnlStatus: TPanel
    Top = 165
    Width = 345
    ExplicitTop = 173
    ExplicitWidth = 345
    inherited pnlNomeForm: TPanel
      Left = 174
      ExplicitLeft = 174
    end
    inherited pnlInfo: TPanel
      Width = 174
      ExplicitWidth = 174
    end
  end
  inherited pnlDados: TPanel
    Width = 345
    Height = 139
    ExplicitWidth = 345
    ExplicitHeight = 147
    inherited gpbDestino: TGroupBox
      Left = 4
      Top = 184
      Width = 226
      Height = 56
      Visible = False
      ExplicitLeft = 4
      ExplicitTop = 184
      ExplicitWidth = 226
      ExplicitHeight = 56
      inherited ColorLabel1: TColorLabel
        Left = 12
        ExplicitLeft = 12
      end
    end
    object chkContaCorrente: TCheckBox
      Left = 4
      Top = 5
      Width = 97
      Height = 17
      Caption = 'Conta Corrente'
      Checked = True
      State = cbChecked
      TabOrder = 1
      OnClick = chkContaCorrenteClick
    end
    object chkProduto: TCheckBox
      Left = 4
      Top = 25
      Width = 67
      Height = 17
      Caption = 'Produto'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object chkCheque: TCheckBox
      Left = 4
      Top = 44
      Width = 65
      Height = 17
      Caption = 'Cheque'
      Checked = True
      State = cbChecked
      TabOrder = 6
    end
    object chkObservacao: TCheckBox
      Left = 148
      Top = 25
      Width = 81
      Height = 17
      Caption = 'Observa'#231#227'o'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object chkDocAg: TCheckBox
      Left = 148
      Top = 5
      Width = 162
      Height = 17
      Caption = 'Documentos de agrupamento'
      Checked = True
      State = cbChecked
      TabOrder = 2
      OnClick = chkContaCorrenteClick
    end
    object chkAjuDta: TCheckBox
      Left = 4
      Top = 100
      Width = 332
      Height = 17
      Caption = 'Ajustar venctos considerando S'#225'bados, Domingos e Feriados'
      TabOrder = 11
    end
    object chkDtaVen: TCheckBox
      Left = 237
      Top = 25
      Width = 73
      Height = 17
      Caption = 'Dta. Venc.'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object chkEndEre: TCheckBox
      Left = 148
      Top = 44
      Width = 181
      Height = 17
      Caption = 'Apresentar endere'#231'o de entrega'
      TabOrder = 7
    end
    object chkJuros: TCheckBox
      Left = 148
      Top = 63
      Width = 65
      Height = 17
      Caption = 'Juros'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object chkBancoDoBoleto: TCheckBox
      Left = 4
      Top = 64
      Width = 125
      Height = 17
      Caption = 'Banco do boleto'
      TabOrder = 8
    end
    object chkNumPedFF: TCheckBox
      Left = 4
      Top = 82
      Width = 97
      Height = 17
      Caption = 'Num. Ped. da FF'
      TabOrder = 10
    end
    object chkCredito: TCheckBox
      Left = 4
      Top = 118
      Width = 332
      Height = 17
      Caption = 'Apresentar limite de cr'#233'dito e cr'#233'dito dispon'#237'vel'
      Checked = True
      State = cbChecked
      TabOrder = 12
    end
    object rdgOrdem: TRadioGroup
      Left = 4
      Top = 138
      Width = 332
      Height = 39
      Caption = 'Ordem das Duplicatas'
      Columns = 3
      Enabled = False
      Items.Strings = (
        'No. Documento'
        'Data Vencimento'
        'Data Cadastro')
      TabOrder = 13
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 144
    Top = 135
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 424
    Top = 176
  end
  inherited rldFiltro: TRLDraftFilter
    Left = 112
    Top = 135
  end
  inherited frxExpRTF: TfrxRTFExport
    Left = 368
    Top = 152
  end
  inherited frxExpXLS: TfrxXLSExport
    Left = 336
    Top = 135
  end
  inherited frxExpHtml: TfrxHTMLExport
    Left = 304
    Top = 135
  end
  inherited frxExpPDF: TfrxPDFExport
    Left = 272
    Top = 135
  end
  inherited frxMatricial: TfrxDotMatrixExport
    Left = 240
    Top = 135
  end
  inherited frxRelatorio: TfrxDBDataset
    Left = 176
    Top = 135
  end
  inherited frxGen: TfrxUserDataSet
    Left = 208
    Top = 135
  end
  inherited frxDesigner: TfrxDesigner
    Left = 432
    Top = 152
  end
  inherited frxComandos: TfrxUserDataSet
    Left = 464
    Top = 152
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 80
    Top = 135
  end
end
