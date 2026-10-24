inherited frmConsultaMapaGoogleMaps: TfrmConsultaMapaGoogleMaps
  Width = 762
  Height = 515
  Align = alClient
  Caption = 'Google Maps'
  KeyPreview = False
  OnDestroy = FormDestroy
  ExplicitWidth = 762
  ExplicitHeight = 515
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 444
    Width = 756
    ExplicitTop = 444
    ExplicitWidth = 756
    inherited FlwBotoes: TFlowPanel
      Width = 752
      ExplicitWidth = 752
      inherited btnConfirma: TBitBtnLocked
        Caption = 'Confirma'
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 676
      Caption = 'Cancela'
      ExplicitLeft = 676
    end
  end
  inherited pnlStatus: TPanel
    Top = 470
    Width = 756
    ExplicitTop = 470
    ExplicitWidth = 756
    inherited pnlNomeForm: TPanel
      Left = 585
      ExplicitLeft = 585
    end
    inherited pnlInfo: TPanel
      Width = 585
      ExplicitWidth = 585
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 368
    Width = 756
    Height = 76
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object lblEndereco: TLabel
      Left = 4
      Top = 29
      Width = 49
      Height = 14
      Caption = 'Endere'#231'o:'
    end
    object lblBairro: TLabel
      Left = 452
      Top = 29
      Width = 32
      Height = 14
      Caption = 'Bairro:'
    end
    object lblCidade: TLabel
      Left = 17
      Top = 52
      Width = 36
      Height = 14
      Caption = 'Cidade:'
    end
    object lblEstado: TLabel
      Left = 370
      Top = 52
      Width = 36
      Height = 14
      Caption = 'Estado:'
    end
    object lblCep: TLabel
      Left = 462
      Top = 52
      Width = 22
      Height = 14
      Caption = 'Cep:'
    end
    object edtEndereco: TEditFocus
      Tag = 99
      Left = 57
      Top = 26
      Width = 384
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCidade: TEditFocus
      Tag = 99
      Left = 57
      Top = 49
      Width = 304
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtEstado: TEditFocus
      Tag = 99
      Left = 408
      Top = 49
      Width = 33
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object btnUtilizarEndereco: TBitBtnLocked
      Left = 0
      Top = 0
      Width = 756
      Height = 22
      Align = alTop
      Caption = 'Utilizar Endere'#231'o Selecionado'
      TabOrder = 0
      OnClick = btnUtilizarEnderecoClick
    end
    object edtBairro: TEditFocus
      Tag = 99
      Left = 487
      Top = 26
      Width = 266
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskCep: TMaskEditFocus
      Tag = 99
      Left = 487
      Top = 49
      Width = 61
      Height = 22
      EditMask = '99999-999;0;'
      MaxLength = 9
      TabOrder = 5
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 756
    Height = 368
    Align = alClient
    TabOrder = 3
    ExplicitLeft = 288
    ExplicitTop = 240
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 704
    Top = 104
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 656
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 584
    Top = 64
  end
end
