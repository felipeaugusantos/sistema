inherited frmDadosContaPagar: TfrmDadosContaPagar
  Width = 788
  Height = 288
  Caption = 'Dados do Pagamento'
  Position = poMainFormCenter
  ExplicitWidth = 788
  ExplicitHeight = 288
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 215
    Width = 782
    ExplicitTop = 215
    ExplicitWidth = 782
    inherited FlwBotoes: TFlowPanel
      Width = 778
      ExplicitWidth = 778
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
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 699
      ExplicitLeft = 699
    end
  end
  inherited pnlStatus: TPanel
    Top = 243
    Width = 782
    ExplicitTop = 243
    ExplicitWidth = 782
    inherited pnlNomeForm: TPanel
      Left = 611
      ExplicitLeft = 611
    end
    inherited pnlInfo: TPanel
      Width = 611
      ExplicitWidth = 611
    end
  end
  object pnlPortador: TPanel [2]
    Left = 0
    Top = 34
    Width = 782
    Height = 23
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label31: TLabel
      Left = 40
      Top = 4
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object edtCodPor: TEditFocus
      Tag = 99
      Left = 88
      Top = 0
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 5
      TabOrder = 0
      OnExit = edtCodPorExit
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
      Left = 151
      Top = 0
      Width = 399
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
  inline fraCtaPagar: TfraCtaPagar [3]
    Left = 0
    Top = 57
    Width = 782
    Height = 155
    Align = alTop
    TabOrder = 4
    ExplicitTop = 57
    ExplicitWidth = 782
    ExplicitHeight = 155
    inherited pnlFundo: TPanel
      Width = 782
      Height = 155
      ExplicitWidth = 782
      ExplicitHeight = 155
      inherited pnlDetalhe: TPanel
        Width = 782
        Height = 819
        Align = alTop
        ExplicitWidth = 782
        ExplicitHeight = 819
        inherited lblVeiobo: TLabel
          Left = 623
          Top = 9
          Width = 63
          Height = 14
          ExplicitLeft = 623
          ExplicitTop = 9
          ExplicitWidth = 63
          ExplicitHeight = 14
        end
        inherited Label13: TLabel
          Left = 7
          Top = 72
          Width = 81
          Height = 14
          ExplicitLeft = 7
          ExplicitTop = 72
          ExplicitWidth = 81
          ExplicitHeight = 14
        end
        inherited Label17: TLabel
          Left = 41
          Top = 97
          Height = 14
          ExplicitLeft = 41
          ExplicitTop = 97
          ExplicitHeight = 14
        end
        inherited Label4: TLabel
          Left = 635
          Top = 78
          Width = 51
          Height = 14
          ExplicitLeft = 635
          ExplicitTop = 78
          ExplicitWidth = 51
          ExplicitHeight = 14
        end
        inherited ColVeiobo: TColorLabel
          Left = 715
          Width = 55
          Height = 14
          ExplicitLeft = 715
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited ColorLabel1: TColorLabel
          Left = 717
          Width = 55
          Height = 14
          ExplicitLeft = 717
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited Label20: TLabel
          Left = 640
          Top = 55
          Height = 14
          ExplicitLeft = 640
          ExplicitTop = 55
          ExplicitHeight = 14
        end
        inherited ColorLabel3: TColorLabel
          Left = 717
          Width = 55
          Height = 14
          ExplicitLeft = 717
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited lblTipoDoc: TLabel
          Left = 38
          Top = 3
          Width = 48
          Height = 14
          ExplicitLeft = 38
          ExplicitTop = 3
          ExplicitWidth = 48
          ExplicitHeight = 14
        end
        inherited Label31: TLabel
          Left = 171
          Top = 26
          Height = 14
          ExplicitLeft = 171
          ExplicitTop = 26
          ExplicitHeight = 14
        end
        inherited ColorLabel5: TColorLabel
          Left = 252
          Top = 26
          Width = 55
          Height = 14
          ExplicitLeft = 252
          ExplicitTop = 26
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited lbl1: TLabel
          Left = 640
          Top = 32
          Width = 46
          Height = 14
          ExplicitLeft = 640
          ExplicitTop = 32
          ExplicitWidth = 46
          ExplicitHeight = 14
        end
        inherited ColorLabel8: TColorLabel
          Left = 717
          Width = 55
          Height = 14
          ExplicitLeft = 717
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited lblGuia: TLabel
          Left = 120
          Top = 5
          Height = 14
          ExplicitLeft = 120
          ExplicitTop = 5
          ExplicitHeight = 14
        end
        inherited Label36: TLabel
          Left = 316
          Top = 26
          Width = 31
          Height = 14
          ExplicitLeft = 316
          ExplicitTop = 26
          ExplicitWidth = 31
          ExplicitHeight = 14
        end
        inherited spbDicaTributo: TSpeedButton
          Left = 530
          Top = 0
          ExplicitLeft = 530
          ExplicitTop = 0
        end
        inherited lblEventos: TLabel
          Left = 50
          Top = 51
          Width = 36
          Height = 14
          Caption = 'Evento:'
          ExplicitLeft = 50
          ExplicitTop = 51
          ExplicitWidth = 36
          ExplicitHeight = 14
        end
        inherited Label34: TLabel
          Left = 21
          Top = 28
          Width = 65
          Height = 14
          ExplicitLeft = 21
          ExplicitTop = 28
          ExplicitWidth = 65
          ExplicitHeight = 14
        end
        inherited Label33: TLabel
          Left = 601
          Top = 122
          Width = 85
          Height = 14
          ExplicitLeft = 601
          ExplicitTop = 122
          ExplicitWidth = 85
          ExplicitHeight = 14
        end
        inherited ColorLabel7: TColorLabel
          Left = 718
          Top = 123
          Width = 55
          Height = 14
          ExplicitLeft = 718
          ExplicitTop = 123
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited Label32: TLabel
          Left = 567
          Top = 101
          Width = 119
          Height = 14
          ExplicitLeft = 567
          ExplicitTop = 101
          ExplicitWidth = 119
          ExplicitHeight = 14
        end
        inherited ColorLabel6: TColorLabel
          Left = 716
          Width = 55
          Height = 14
          ExplicitLeft = 716
          ExplicitWidth = 55
          ExplicitHeight = 14
        end
        inherited edtNomCta: TEditFocus
          Left = 144
          Top = 69
          Height = 22
          ExplicitLeft = 144
          ExplicitTop = 69
          ExplicitHeight = 22
        end
        inherited cbxBcoFor: TComboBoxFocus
          Left = 350
          Top = 23
          ExplicitLeft = 350
          ExplicitTop = 23
        end
        inherited LcbGuiaTributo: TDBLookupComboBox
          Left = 150
          Top = 0
          Height = 22
          ExplicitLeft = 150
          ExplicitTop = 0
          ExplicitHeight = 22
        end
        inherited LcbTipoTributo: TDBLookupComboBox
          Left = 252
          Top = 0
          Width = 274
          Height = 22
          ExplicitLeft = 252
          ExplicitTop = 0
          ExplicitWidth = 274
          ExplicitHeight = 22
        end
        inherited edtDeposi: TEditFocus
          Left = 224
          Top = 23
          Height = 22
          ExplicitLeft = 224
          ExplicitTop = 23
          ExplicitHeight = 22
        end
        inherited MemHisto: TMemo
          Left = 88
          Top = 92
          ExplicitLeft = 88
          ExplicitTop = 92
        end
        inherited edtTipDoc: TEditFocus
          Left = 88
          Top = 0
          Height = 22
          ExplicitLeft = 88
          ExplicitTop = 0
          ExplicitHeight = 22
        end
        inherited edtVeiobo: TEditFocus
          Left = 687
          Height = 22
          ExplicitLeft = 687
          ExplicitHeight = 22
        end
        inherited edtVeioNF: TEditFocus
          Left = 687
          Height = 22
          ExplicitLeft = 687
          ExplicitHeight = 22
        end
        inherited edtUsaChq: TEditFocus
          Left = 687
          Height = 22
          ExplicitLeft = 687
          ExplicitHeight = 22
        end
        inherited edtPrevis: TEditFocus
          Left = 687
          Height = 22
          ExplicitLeft = 687
          ExplicitHeight = 22
        end
        inherited edtDesEve: TEditFocus
          Left = 144
          Top = 46
          Height = 22
          ExplicitLeft = 144
          ExplicitTop = 46
          ExplicitHeight = 22
        end
        inherited edtCodEve: TEditFocus
          Left = 88
          Top = 46
          Height = 22
          OnKeyPress = fraCtaPagaredtCodEveKeyPress
          ExplicitLeft = 88
          ExplicitTop = 46
          ExplicitHeight = 22
        end
        inherited edtCodCta: TMaskEditFocus
          Left = 88
          Top = 69
          Height = 22
          OnKeyPress = fraCtaPagaredtCodCtaKeyPress
          ExplicitLeft = 88
          ExplicitTop = 69
          ExplicitHeight = 22
        end
        inherited edtCompet: TMaskEditFocus
          Left = 88
          Top = 23
          Height = 22
          ExplicitLeft = 88
          ExplicitTop = 23
          ExplicitHeight = 22
        end
        inherited edtPagAnt: TEditFocus
          Left = 687
          Top = 96
          Height = 22
          ExplicitLeft = 687
          ExplicitTop = 96
          ExplicitHeight = 22
        end
        inherited edtUsoCon: TEditFocus
          Left = 687
          Top = 119
          Height = 22
          ExplicitLeft = 687
          ExplicitTop = 119
          ExplicitHeight = 22
        end
      end
    end
    inherited HintControler: TcxHintStyleController
      Left = 232
      Top = 120
    end
  end
  object pnlFornecedor: TPanel [4]
    Left = 0
    Top = 0
    Width = 782
    Height = 34
    Align = alTop
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblFornecedor: TLabel
      Left = 25
      Top = 15
      Width = 59
      Height = 14
      Caption = 'Fornecedor:'
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 88
      Top = 11
      Width = 62
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 8
      ParentFont = False
      TabOrder = 0
      OnExit = edtCodForExit
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 151
      Top = 11
      Width = 399
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  inherited mnuAuxiliar: TPopupMenu [5]
    Left = 432
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents [6]
    Left = 384
    Top = 128
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 312
    Top = 152
  end
end
