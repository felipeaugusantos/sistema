inherited frmCtpFormasPagamento: TfrmCtpFormasPagamento
  Left = 468
  Top = 314
  Width = 618
  Height = 247
  BorderIcons = [biSystemMenu]
  Caption = 'Formas de Pagamento'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 618
  ExplicitHeight = 247
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 174
    Width = 612
    TabOrder = 2
    ExplicitTop = 174
    ExplicitWidth = 612
    DesignSize = (
      612
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 608
      TabOrder = 3
    end
    inherited btnSair: TBitBtnLocked
      Left = 529
      TabOrder = 2
      ExplicitLeft = 529
    end
    object btnConfirmaDados: TBitBtnLocked
      Left = 3
      Top = 3
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
      TabOrder = 0
      OnClick = btnConfirmaDadosClick
    end
    object btnConfereCheques: TBitBtnLocked
      Left = 83
      Top = 3
      Width = 150
      Height = 22
      Caption = 'C&onfer'#234'ncia de Cheques'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000030000000E000000150000000C0000
        0002000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000200000012072B199C136940FF051E127A0000
        000C000000010000000000000000000000000000000000000000000000000000
        0000000000000000000200000010082D1B9A278B63FF3CB58BFF16623FF4020B
        063D000000060000000000000000000000000000000000000000000000000000
        0000000000020000000E082F1C972C9068FF45C097FF44BF96FF36A67DFF0C46
        2BCE000000150000000200000000000000000000000000000000000000000000
        00010000000C09321F9430966FFF56CAA4FF95E3C8FF7BD7B8FF48C39AFF2A8D
        65FF082B1A8A0000000C00000001000000000000000000000000000000000000
        00060A352190349B75FF7BDBBBFFACE9D3FF4EA07EFF6DB99AFF7DDABBFF4CC4
        9DFF1F7852FC03120B4800000007000000010000000000000000000000000000
        00084B8E60FF99E8CEFF90D0B7FF287F5BEF09281B680E422D9A6EBA9DFF75D9
        B7FF4ABE97FF196747E70209062B000000040000000000000000000000000000
        0003082016494D9063FF14573CB2020B0723000000070000000C135239B280CA
        AEFF71D8B8FF46B691FF135639CA000101140000000200000000000000000000
        0000000000030000000600000005000000020000000000000002010302121A63
        44C28CD3B9FF7ADDBEFF3FAA84FF0D432CA10000000D00000002000000000000
        0000000000000000000000000000000000000000000000000000000000020105
        03151B6748C484CFB3FF81E1C4FF38A27BFF0B34237D00000007000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000101030210175E42B27ECCAFFF97E9D0FF4E9265FF00000009000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000010002010B15573DA5509769FF0822184A00000004000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000100000004000000060000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 1
      OnClick = btnConfereChequesClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 202
    Width = 612
    ExplicitTop = 202
    ExplicitWidth = 612
    inherited pnlNomeForm: TPanel
      Left = 441
      ExplicitLeft = 441
    end
    inherited pnlInfo: TPanel
      Width = 441
      ExplicitWidth = 441
    end
  end
  object pnlTotal: TPanel [2]
    Left = 0
    Top = 0
    Width = 612
    Height = 28
    Align = alTop
    Color = 16770261
    TabOrder = 3
    DesignSize = (
      612
      28)
    object lblValTot: TLabel
      Left = 512
      Top = 3
      Width = 86
      Height = 19
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Valor Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlValDig: TPanel [3]
    Left = 0
    Top = 146
    Width = 612
    Height = 28
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    DesignSize = (
      612
      28)
    object lblValDig: TLabel
      Left = 3
      Top = 3
      Width = 113
      Height = 19
      Caption = 'Valor Digitado:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblValRes: TLabel
      Left = 481
      Top = 3
      Width = 117
      Height = 19
      Alignment = taRightJustify
      Anchors = [akRight, akBottom]
      Caption = 'Valor Restante:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlFundo: TPanel [4]
    Left = 0
    Top = 28
    Width = 612
    Height = 118
    Align = alClient
    Color = 16770261
    TabOrder = 0
    object lblDinheiro: TLabel
      Left = 435
      Top = 17
      Width = 42
      Height = 14
      Caption = 'Dinheiro:'
    end
    object lblChqVista: TLabel
      Left = 401
      Top = 41
      Width = 76
      Height = 14
      Caption = 'Cheque Emitido:'
    end
    object lblRepChq: TLabel
      Left = 374
      Top = 90
      Width = 103
      Height = 14
      Caption = 'Cheque de Terceiros:'
    end
    object lblOrdPag: TLabel
      Left = 386
      Top = 68
      Width = 91
      Height = 14
      Caption = 'Dep'#243'sito Banc'#225'rio:'
    end
    object lblPorBaiDin: TLabel
      Left = 5
      Top = 20
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblPorBaiChV: TLabel
      Left = 5
      Top = 42
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblPorBaiOrd: TLabel
      Left = 5
      Top = 68
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object lblPorBaiRep: TLabel
      Left = 5
      Top = 92
      Width = 44
      Height = 14
      Alignment = taRightJustify
      Caption = 'Portador:'
    end
    object edtPorBaiDin: TEditFocus
      Tag = 99
      Left = 51
      Top = 15
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnKeyPress = edtPorBaiDinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorDin: TEditFocus
      Left = 117
      Top = 15
      Width = 252
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPorBaiChV: TEditFocus
      Tag = 99
      Left = 51
      Top = 39
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 2
      OnKeyPress = edtPorBaiDinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorChV: TEditFocus
      Left = 117
      Top = 39
      Width = 252
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPorBaiOrd: TEditFocus
      Tag = 99
      Left = 51
      Top = 63
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 4
      OnKeyPress = edtPorBaiDinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorOrd: TEditFocus
      Left = 117
      Top = 63
      Width = 252
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 11
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtPorBaiRep: TEditFocus
      Tag = 99
      Left = 51
      Top = 87
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 6
      OnKeyPress = edtPorBaiDinKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDesPorRep: TEditFocus
      Left = 117
      Top = 87
      Width = 252
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 12
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDinheiro: TEditFocus
      Tag = 99
      Left = 483
      Top = 13
      Width = 113
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtChqVista: TEditFocus
      Tag = 99
      Left = 506
      Top = 36
      Width = 89
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtRepChq: TEditFocus
      Tag = 99
      Left = 506
      Top = 86
      Width = 89
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtOrdPag: TEditFocus
      Tag = 99
      Left = 483
      Top = 60
      Width = 112
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      Enabled = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object btnSelChAvi: TBitBtnLocked
      Left = 482
      Top = 86
      Width = 24
      Height = 21
      Hint = 'Selecionar Cheques para repasse...'
      Enabled = False
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 7
      OnClick = btnSelChAviClick
      OnEnter = btnSelChAviEnter
    end
    object btnAltValChqEmi: TBitBtnLocked
      Left = 482
      Top = 37
      Width = 24
      Height = 21
      Hint = 'Alterar cheques emitidos...'
      Enabled = False
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        00000000000000000001000000050000000D0000000F00000005000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000020000000A170F093B72472CC3A1643DFF00000010000000000000
        0000000000000000000000000000000000000000000000000000000000010000
        00060604031955382594AB754CF9D5A670FFA56942FF00000022000000110000
        000D000000080000000300000000000000000000000000000000000000053525
        195F9A6A48E5CB9C6DFFE8C089FFE8C189FFA86F48FF88512EFC724125E4532E
        17B92F1A0D7B090502270000000700000001000000000000000000000008BD8D
        64FFECD4B3FFF1D8ACFFEBCA95FFEAC68FFFE7CBA4FFF2DBB9FFE1C39EFFC59D
        74FFA16F47FF512C16BE1B0E065200000008000000010000000000000004392C
        1F59A8815EE2DBBB97FFF3DFBDFFF0D4A6FFC69C74FFBB8B62FFC49870FFD3AE
        89FFE0C29BFFB78A60FF5C351CCB120A043E0000000400000000000000010000
        000407050415614B378CC39D76F9E7CEADFFC1936AFF060503242B21174E644A
        359AB48F6BECD7B891FFAB7E56FF3C2110970000000A00000000000000020000
        00080000000B0000000F1A140F328A6C4FBBC79A70FF0000000C000000040000
        000C56412F86D2AD87FFD8BD9DFF60351CD50000000F00000000000000062379
        49F9237B4AFF247A4AFF030A06220000000900000009000000060000000A0000
        000B100C0927C5996FFFC4986EFFAE7C57F90000000D0000000000000005246E
        49CE5BC49EFF308E62FF0D311C7E00000008000000030000000A247B4AFF0A37
        1ABF020B053900000015000000110000000D000000030000000000000003194B
        32885BB691FF6DC3A6FF2F7A54EA103B229107190F470104021C267F4DFF34A5
        78FF17633BF9092B169101030218000000060000000100000000000000010919
        112F2C7451C07AC8AAFF8BD7BFFF56A886FF33875DFF207345FF3A976AFF6ADA
        BBFF4BC89FFF30966AFF145530E5061D0F5F0000000600000000000000000000
        00020E251A41266C4BB263BB96FF8AD3BAFFA8E7D6FFBAF3E7FFA4E4D2FF89EA
        D5FF77E1C6FF75DDBDFF80D7BCFF278551FF0000000A00000000000000000000
        000000000002050D091A17412D6A276D4CAD338E64DF3AA06FFB3AA271FF9EF0
        E0FFB4F1E5FF6EC5A3FF348B60E1102E1F5A0000000500000000000000000000
        000000000000000000010000000200000004000000050000000C3EA977FF9AE0
        C9FF4CAC82F81E52398902060415000000040000000100000000000000000000
        000000000000000000000000000000000000000000000000000541AF7DFF2D79
        56B70816102B0000000500000001000000000000000000000000}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 13
      TabStop = False
      OnClick = btnAltValChqEmiClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 576
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 344
    Top = 65528
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 65528
  end
end
