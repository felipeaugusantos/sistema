inherited frmFiscCtpEntrada: TfrmFiscCtpEntrada
  Width = 836
  Height = 277
  Caption = 'Lan'#231'amento de contas a pagar'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 836
  ExplicitHeight = 277
  PixelsPerInch = 96
  TextHeight = 14
  object pnlDetalhe: TPanel [0]
    Left = 0
    Top = 0
    Width = 830
    Height = 50
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblCndPag: TLabel
      Left = 39
      Top = 33
      Width = 61
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cond. Pagto:'
    end
    object Label31: TLabel
      Left = 56
      Top = 9
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object edtCodCnd: TEditFocus
      Tag = 99
      Left = 103
      Top = 28
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodCndKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object mskCndPag: TMaskEditFocus
      Tag = 99
      Left = 166
      Top = 28
      Width = 624
      Height = 22
      CharCase = ecUpperCase
      Enabled = False
      EditMask = 
        '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
        '99.999.999.999.999.999.999.999.999;0;'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 98
      TabOrder = 3
      Text = ''
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 103
      Top = 5
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtCodPorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtNomPor: TEditFocus
      Left = 166
      Top = 5
      Width = 624
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object LabeledEdit1: TLabeledEdit [1]
    Left = 393
    Top = 333
    Width = 121
    Height = 22
    EditLabel.Width = 61
    EditLabel.Height = 14
    EditLabel.Caption = 'LabeledEdit1'
    TabOrder = 4
  end
  inherited pnlBotoes: TPanel
    Top = 206
    Width = 830
    Height = 26
    TabOrder = 2
    ExplicitTop = 206
    ExplicitWidth = 830
    ExplicitHeight = 26
    DesignSize = (
      830
      26)
    inherited FlwBotoes: TFlowPanel
      Width = 826
      Height = 22
      TabOrder = 1
      ExplicitWidth = 826
      ExplicitHeight = 22
      object btnConfirmaDados: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 77
        Height = 22
        Caption = '&Confirma'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
          7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF313131726E726A66697D797A2929293838384242422828286868683131
          31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
          6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
          CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
          203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
          A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
          E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
          D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
          ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
          FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
          2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
          5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
          DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
          D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
          C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
        ModalResult = 1
        TabOrder = 0
        OnClick = btnConfirmaDadosClick
      end
      object btnDesmembr: TBitBtnLocked
        Left = 77
        Top = 0
        Width = 135
        Height = 22
        Anchors = [akLeft, akBottom]
        Caption = '[ F8 ] Desmembra Valores'
        TabOrder = 1
        OnClick = btnDesmembrClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 747
      Top = 1
      TabOrder = 0
      ExplicitLeft = 747
      ExplicitTop = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 232
    Width = 830
    TabOrder = 3
    ExplicitTop = 232
    ExplicitWidth = 830
    inherited pnlNomeForm: TPanel
      Left = 659
      ExplicitLeft = 659
    end
    inherited pnlInfo: TPanel
      Width = 659
      ExplicitWidth = 659
    end
  end
  inline fraCtaPagar: TfraCtaPagar [4]
    Left = 0
    Top = 50
    Width = 830
    Height = 155
    Align = alTop
    TabOrder = 1
    ExplicitTop = 50
    ExplicitWidth = 830
    ExplicitHeight = 155
    inherited pnlFundo: TPanel
      Width = 830
      Height = 155
      ExplicitWidth = 830
      ExplicitHeight = 155
      inherited pnlDetalhe: TPanel
        Height = 155
        ExplicitHeight = 155
        inherited lblVeiobo: TLabel
          Left = 638
          Top = 9
          Width = 63
          Height = 14
          ExplicitLeft = 638
          ExplicitTop = 9
          ExplicitWidth = 63
          ExplicitHeight = 14
        end
        inherited Label13: TLabel
          Left = 22
          Top = 73
          Width = 81
          Height = 14
          ExplicitLeft = 22
          ExplicitTop = 73
          ExplicitWidth = 81
          ExplicitHeight = 14
        end
        inherited Label17: TLabel
          Top = 90
          Height = 14
          ExplicitTop = 90
          ExplicitHeight = 14
        end
        inherited Label4: TLabel
          Left = 650
          Width = 51
          Height = 14
          ExplicitLeft = 650
          ExplicitWidth = 51
          ExplicitHeight = 14
        end
        inherited ColVeiobo: TColorLabel
          Left = 732
          Width = 55
          Height = 14
          ExplicitLeft = 732
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited ColorLabel1: TColorLabel
          Left = 734
          Width = 55
          Height = 14
          ExplicitLeft = 734
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited Label20: TLabel
          Left = 655
          Height = 14
          ExplicitLeft = 655
          ExplicitHeight = 14
        end
        inherited ColorLabel3: TColorLabel
          Left = 734
          Width = 55
          Height = 14
          ExplicitLeft = 734
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited lblTipoDoc: TLabel
          Top = 4
          Width = 48
          Height = 14
          ExplicitTop = 4
          ExplicitWidth = 48
          ExplicitHeight = 14
        end
        inherited Label31: TLabel
          Left = 183
          Top = 27
          Height = 14
          ExplicitLeft = 183
          ExplicitTop = 27
          ExplicitHeight = 14
        end
        inherited ColorLabel5: TColorLabel
          Top = 27
          Width = 55
          Height = 14
          ExplicitTop = 27
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited lbl1: TLabel
          Left = 655
          Top = 32
          Width = 46
          Height = 14
          ExplicitLeft = 655
          ExplicitTop = 32
          ExplicitWidth = 46
          ExplicitHeight = 14
        end
        inherited ColorLabel8: TColorLabel
          Left = 734
          Width = 55
          Height = 14
          ExplicitLeft = 734
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited lblGuia: TLabel
          Left = 136
          Top = 3
          Height = 14
          ExplicitLeft = 136
          ExplicitTop = 3
          ExplicitHeight = 14
        end
        inherited Label36: TLabel
          Left = 330
          Top = 27
          Width = 31
          Height = 14
          ExplicitLeft = 330
          ExplicitTop = 27
          ExplicitWidth = 31
          ExplicitHeight = 14
        end
        inherited spbDicaTributo: TSpeedButton
          Top = 0
          ExplicitTop = 0
        end
        inherited lblEventos: TLabel
          Left = 16
          Top = 50
          Width = 87
          Height = 14
          ExplicitLeft = 16
          ExplicitTop = 50
          ExplicitWidth = 87
          ExplicitHeight = 14
        end
        inherited Label34: TLabel
          Left = 37
          Top = 27
          Width = 65
          Height = 14
          ExplicitLeft = 37
          ExplicitTop = 27
          ExplicitWidth = 65
          ExplicitHeight = 14
        end
        inherited Label33: TLabel
          Left = 617
          Top = 123
          Width = 85
          Height = 14
          ExplicitLeft = 617
          ExplicitTop = 123
          ExplicitWidth = 85
          ExplicitHeight = 14
        end
        inherited ColorLabel7: TColorLabel
          Left = 733
          Top = 123
          Width = 55
          Height = 14
          ExplicitLeft = 733
          ExplicitTop = 123
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited Label32: TLabel
          Left = 583
          Top = 99
          Width = 119
          Height = 14
          ExplicitLeft = 583
          ExplicitTop = 99
          ExplicitWidth = 119
          ExplicitHeight = 14
        end
        inherited ColorLabel6: TColorLabel
          Left = 733
          Top = 99
          Width = 55
          Height = 14
          ExplicitLeft = 733
          ExplicitTop = 99
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited edtNomCta: TEditFocus
          Top = 70
          Height = 22
          ExplicitTop = 70
          ExplicitHeight = 22
        end
        inherited cbxBcoFor: TComboBoxFocus
          Top = 24
          OnChange = fraCtaPagarcbxBcoForChange
          ExplicitTop = 24
        end
        inherited LcbGuiaTributo: TDBLookupComboBox
          Top = 1
          Height = 22
          TabOrder = 0
          ExplicitTop = 1
          ExplicitHeight = 22
        end
        inherited LcbTipoTributo: TDBLookupComboBox
          Top = 1
          Height = 22
          TabOrder = 1
          ExplicitTop = 1
          ExplicitHeight = 22
        end
        inherited edtDeposi: TEditFocus
          Left = 234
          Top = 24
          Height = 22
          OnExit = fraCtaPagaredtDeposiExit
          ExplicitLeft = 234
          ExplicitTop = 24
          ExplicitHeight = 22
        end
        inherited MemHisto: TMemo
          Top = 93
          TabOrder = 14
          ExplicitTop = 93
        end
        inherited edtTipDoc: TEditFocus
          Top = 1
          Height = 22
          TabOrder = 2
          OnEnter = fraCtaPagaredtTipDocEnter
          OnExit = fraCtaPagaredtTipDocExit
          ExplicitTop = 1
          ExplicitHeight = 22
        end
        inherited edtVeiobo: TEditFocus
          Left = 704
          Height = 22
          ExplicitLeft = 704
          ExplicitHeight = 22
        end
        inherited edtVeioNF: TEditFocus
          Left = 704
          Height = 22
          ExplicitLeft = 704
          ExplicitHeight = 22
        end
        inherited edtUsaChq: TEditFocus
          Left = 704
          Height = 22
          ExplicitLeft = 704
          ExplicitHeight = 22
        end
        inherited edtPrevis: TEditFocus
          Left = 704
          Height = 22
          ExplicitLeft = 704
          ExplicitHeight = 22
        end
        inherited edtDesEve: TEditFocus
          Top = 47
          Height = 22
          ExplicitTop = 47
          ExplicitHeight = 22
        end
        inherited edtCodEve: TEditFocus
          Top = 47
          Height = 22
          OnKeyPress = fraCtaPagaredtCodEveKeyPress
          ExplicitTop = 47
          ExplicitHeight = 22
        end
        inherited edtCodCta: TMaskEditFocus
          Top = 70
          Height = 22
          OnKeyPress = fraCtaPagaredtCodCtaKeyPress
          ExplicitTop = 70
          ExplicitHeight = 22
        end
        inherited edtCompet: TMaskEditFocus
          Top = 24
          Height = 22
          ExplicitTop = 24
          ExplicitHeight = 22
        end
        inherited edtPagAnt: TEditFocus
          Left = 704
          Top = 96
          Height = 22
          TabOrder = 15
          ExplicitLeft = 704
          ExplicitTop = 96
          ExplicitHeight = 22
        end
        inherited edtUsoCon: TEditFocus
          Left = 704
          Top = 119
          Height = 22
          TabOrder = 16
          ExplicitLeft = 704
          ExplicitTop = 119
          ExplicitHeight = 22
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu [5]
    Left = 233
    Top = 181
  end
  inherited ApplicationEvents: TApplicationEvents [6]
    Left = 185
    Top = 181
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 281
    Top = 165
  end
end
