inherited frmCadOcorrenciasGia: TfrmCadOcorrenciasGia
  Width = 573
  Height = 264
  Caption = 'Cadastro de Ocorr'#234'ncias GIA'
  ExplicitWidth = 573
  ExplicitHeight = 264
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 191
    Width = 567
    ExplicitTop = 191
    ExplicitWidth = 567
    inherited FlwBotoes: TFlowPanel
      Width = 563
      ExplicitWidth = 563
    end
    inherited btnSair: TBitBtnLocked
      Left = 484
      ExplicitLeft = 484
    end
  end
  inherited pnlStatus: TPanel
    Top = 219
    Width = 567
    ExplicitTop = 219
    ExplicitWidth = 567
    inherited pnlNomeForm: TPanel
      Left = 220
      ExplicitLeft = 220
    end
    inherited pnlInfo: TPanel
      Width = 220
      ExplicitWidth = 220
    end
  end
  inherited pgcDados: TPageControl
    Width = 567
    Height = 191
    ActivePage = nil
    ExplicitWidth = 567
    ExplicitHeight = 191
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitTop = 6
      ExplicitWidth = 559
      ExplicitHeight = 181
    end
  end
  object pnlCentral: TPanel [3]
    Left = 0
    Top = 0
    Width = 567
    Height = 191
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object Label5: TLabel
      Left = 12
      Top = 8
      Width = 22
      Height = 14
      Caption = 'Data'
    end
    object Label2: TLabel
      Left = 12
      Top = 53
      Width = 66
      Height = 14
      Caption = 'C'#243'd. SubItem:'
    end
    object Label3: TLabel
      Left = 105
      Top = 53
      Width = 69
      Height = 14
      Caption = 'Valor SubItem:'
    end
    object Label1: TLabel
      Left = 12
      Top = 96
      Width = 214
      Height = 14
      Caption = 'Fundamenta'#231#227'o legal associada ao SubItem:'
    end
    object Label18: TLabel
      Left = 12
      Top = 136
      Width = 54
      Height = 14
      Caption = 'Ocorr'#234'ncia'
    end
    object mskDtaMes: TcxDBMaskEdit
      Tag = 99
      Left = 12
      Top = 25
      DataBinding.DataField = 'OCR_DTAOCR'
      DataBinding.DataSource = dtsCadOcr
      Properties.EditMask = '99/99/9999;1;_'
      Style.BorderStyle = ebsUltraFlat
      StyleFocused.TextStyle = []
      TabOrder = 0
      Width = 73
    end
    object rgIndicaOperacaoPropriaOuSt: TRadioGroup
      Left = 102
      Top = 8
      Width = 446
      Height = 41
      Caption = 'Opera'#231#227'o'
      Columns = 2
      Enabled = False
      ItemIndex = 0
      Items.Strings = (
        'Pr'#243'pria'
        'Subst. Tribut'#225'ria')
      TabOrder = 1
    end
    object edtCodSubIte: TDBEditFocus
      Tag = 99
      Left = 12
      Top = 67
      Width = 84
      Height = 22
      CharCase = ecUpperCase
      DataField = 'OCR_CODITE'
      DataSource = dtsCadOcr
      MaxLength = 5
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object edtValSubIte: TDBEditFocus
      Tag = 99
      Left = 102
      Top = 67
      Width = 121
      Height = 22
      CharCase = ecUpperCase
      DataField = 'OCR_VALITE'
      DataSource = dtsCadOcr
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object lcbFundamentoLegal: TDBLookupComboBox
      Left = 12
      Top = 110
      Width = 536
      Height = 22
      DataField = 'OCR_FLAITE'
      DataSource = dtsCadOcr
      KeyField = 'AUTOINCREM'
      ListField = 'FUL_DESFUL'
      ListSource = dtsDescricaoFundamentoLegal
      TabOrder = 4
    end
    object lcbDescricaoOcorrencia: TDBLookupComboBox
      Left = 12
      Top = 150
      Width = 536
      Height = 22
      DataField = 'OCR_OCORRE'
      DataSource = dtsCadOcr
      KeyField = 'AUTOINCREM'
      ListField = 'DOC_DESDOC'
      ListSource = dtsDescricaoOcorrencia
      TabOrder = 5
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 728
  end
  object dtsCadOcr: TDataSource
    OnStateChange = dtsCadOcrStateChange
    Left = 520
    Top = 8
  end
  object dtsDescricaoFundamentoLegal: TDataSource
    Left = 480
    Top = 56
  end
  object dtsDescricaoOcorrencia: TDataSource
    Left = 520
    Top = 56
  end
end
