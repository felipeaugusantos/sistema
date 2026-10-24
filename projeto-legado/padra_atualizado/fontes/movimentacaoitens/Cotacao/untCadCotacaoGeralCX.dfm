inherited frmCadCotacaoGeralCX: TfrmCadCotacaoGeralCX
  Width = 1366
  Height = 780
  BorderStyle = bsSizeable
  Caption = 'Cota'#231#227'o'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitTop = -17
  ExplicitWidth = 1366
  ExplicitHeight = 780
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 697
    Width = 1350
    ExplicitTop = 697
    ExplicitWidth = 1350
    inherited FlwBotoes: TFlowPanel
      Width = 1269
      ExplicitWidth = 1269
      object btnGravar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 124
        Height = 24
        Align = alLeft
        Caption = '&Gravar Cota'#231#227'o'
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
        OnClick = btnGravarClick
      end
      object btnComSisAnt: TBitBtnLocked
        Left = 124
        Top = 0
        Width = 174
        Height = 24
        Align = alLeft
        Caption = '[ F1 ] Compras do sistema anterior'
        TabOrder = 1
        OnClick = btnComSisAntClick
      end
      object btnEncerra: TBitBtnLocked
        Left = 298
        Top = 0
        Width = 124
        Height = 24
        Caption = '&Encerrar Cota'#231#227'o'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000030000
          000B000000120000001300000013000000140000001400000014000000140000
          0014000000140000001500000015000000140000000D000000030000000B1C11
          6CC3261796FF271696FF261695FF261594FF251594FF251594FF241394FF2412
          93FF241292FF231292FF231192FF231191FF190C68C50000000C0000000F2B1C
          9BFF384AD3FF2637CEFF3042D2FF4254D9FF3646D4FF2437CCFF2434CCFF3444
          D3FF3C4ED6FF2A3ACEFF202FC9FF1E2CC9FF251595FF000000120000000F3121
          A0FF4356D7FF374BD5FF3F4BCBFF2827ABFF363CBEFF3E4FD6FF3D4ED5FF353A
          BEFF2827ABFF3B45C9FF2F41D0FF2332CCFF291A99FF000000120000000E3529
          A5FF4E62DBFF444FCCFF605DBDFFEDEDF8FF8B89CEFF383CBCFF383CBBFF8B89
          CEFFEDEDF8FF5F5DBDFF3D47C9FF293ACEFF2D1F9EFF000000110000000D392F
          ABFF596FDFFF2722A5FFECE7ECFFF5EBE4FFF8F2EEFF9491D1FF9491D1FFF8F1
          EDFFF3E9E2FFECE6EBFF2721A5FF2F42D1FF3326A3FF0000000F0000000C4036
          B1FF657AE2FF3135B7FF8070ADFFEBDBD3FFF4EAE4FFF7F2EDFFF8F1EDFFF4E9
          E2FFEADAD1FF7F6FACFF2E31B6FF3549D5FF372CA9FF0000000E0000000B453D
          B6FF6E83E5FF485EDCFF393BB7FF8A7FB9FFF6ECE7FFF5ECE6FFF4EBE5FFF6EB
          E5FF897DB8FF3739B6FF4054D9FF3D51D7FF3C33AFFF0000000D0000000A4A44
          BCFF788FE8FF6077E3FF4B4BBBFF9189C7FFF7EFE9FFF6EEE9FFF6EFE8FFF7ED
          E8FF9087C5FF4949BAFF596FDFFF4359DAFF423AB4FF0000000C00000009504C
          C2FF92A7EEFF5655BCFF8F89CAFFFBF6F4FFF7F1ECFFEDE1D9FFEDE0D9FFF7F0
          EAFFFAF5F2FF8F89CAFF5453BCFF6278E2FF4943B9FF0000000B000000086B6A
          D0FFADC1F4FF2A1E9BFFE5DADEFFF6EEEBFFEDDFDAFF816EA9FF816EA9FFEDDF
          D8FFF4ECE7FFE5D9DCFF2A1D9BFF8B9EEBFF6563C9FF0000000A000000077577
          D6FFB1C6F5FF6E77D1FF5747A1FFCCB6BCFF7A68A8FF4E4CB7FF4F4EB8FF7A68
          A8FFCBB5BCFF5746A1FF6B75D0FF8EA1ECFF706ED0FF0000000900000006797B
          DAFFB5CAF6FF93A7EEFF7079D2FF2E229BFF5453BBFF93A7EEFF93A7EEFF5555
          BCFF2E219BFF6F77D1FF91A4EDFF90A3EDFF7475D4FF00000008000000057D80
          DEFFB9CDF6FFB9CDF6FFB9CCF6FFB9CCF6FFB9CDF6FFB8CCF6FFB8CCF6FFB7CC
          F6FFB7CBF6FFB6CBF6FFB5C9F6FFB5C9F6FF787AD8FF00000006000000036062
          A6C08184E1FF8183E0FF8083E0FF7F83DFFF7F83DFFF7F82DFFF7E81DFFF7E81
          DEFF7D81DEFF7D80DEFF7D7FDEFF7C7FDDFF5C5EA3C100000004000000000000
          0002000000030000000400000004000000040000000400000004000000040000
          0004000000040000000400000005000000050000000300000001}
        TabOrder = 2
        OnClick = btnEncerraClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1271
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 1271
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 725
    Width = 1350
    ExplicitTop = 725
    ExplicitWidth = 1350
    inherited pnlNomeForm: TPanel
      Left = 1179
      ExplicitLeft = 1179
    end
    inherited pnlInfo: TPanel
      Width = 1179
      ExplicitWidth = 1179
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 0
    Width = 1350
    Height = 82
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 98
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero da Cota'#231#227'o:'
    end
    object Label2: TLabel
      Left = 54
      Top = 39
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 198
      Top = 14
      Width = 87
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Cadastro:'
    end
    object Label4: TLabel
      Left = 394
      Top = 16
      Width = 110
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data de Encerramento:'
    end
    object Label5: TLabel
      Left = 50
      Top = 62
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Comprador:'
    end
    object lblCodSolicitacaoVinculada: TLabel
      Left = 574
      Top = 62
      Width = 80
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cod. Solicita'#231#227'o:'
    end
    object lblEmpDes: TLabel
      Left = 620
      Top = 12
      Width = 84
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa Destino:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object dbeNumCot: TDBEditFocus
      Tag = 99
      Left = 112
      Top = 8
      Width = 73
      Height = 22
      DataField = 'COT_NUMCOT'
      DataSource = dtsCotGer
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 112
      Top = 31
      Width = 276
      Height = 22
      CharCase = ecUpperCase
      DataField = 'COT_DESCRI'
      DataSource = dtsCotGer
      MaxLength = 100
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaCad: TDBEditFocus
      Tag = 99
      Left = 291
      Top = 8
      Width = 97
      Height = 22
      TabStop = False
      DataField = 'COT_DTACAD'
      DataSource = dtsCotGer
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = True
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeDtaFin: TDBEditFocus
      Tag = 99
      Left = 510
      Top = 8
      Width = 97
      Height = 22
      TabStop = False
      DataField = 'COT_DTAFIN'
      DataSource = dtsCotGer
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = True
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object edtNomCmp: TEditFocus
      Left = 159
      Top = 54
      Width = 141
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodCmp: TEditFocus
      Tag = 99
      Left = 112
      Top = 54
      Width = 49
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      PasswordChar = '*'
      TabOrder = 4
      OnKeyPress = edtCodCmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object dbeMulLoj: TDBCheckBox
      Left = 737
      Top = 59
      Width = 114
      Height = 17
      BiDiMode = bdLeftToRight
      Caption = 'Cota'#231#227'o Multi-lojas'
      DataField = 'COT_MULLOJ'
      DataSource = dtsCotGer
      ParentBiDiMode = False
      TabOrder = 7
      ValueChecked = 'S'
      ValueUnchecked = 'N'
      OnClick = dbeMulLojClick
    end
    object pnlDigitador: TPanel
      Left = 303
      Top = 54
      Width = 265
      Height = 25
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 5
      object lblTitDig: TLabel
        Left = 2
        Top = 8
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Digitador:'
      end
      object edtNomDig: TEditFocus
        Left = 100
        Top = 0
        Width = 165
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodDig: TEditFocus
        Tag = 99
        Left = 50
        Top = 0
        Width = 49
        Height = 22
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 40
        PasswordChar = '*'
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
    end
    object dbeEmpDes: TDBEditFocus
      Tag = 99
      Left = 707
      Top = 8
      Width = 45
      Height = 22
      TabStop = False
      Color = 16768952
      DataField = 'COT_EMPDES'
      DataSource = dtsCotGer
      TabOrder = 9
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object pnlTipoCotac: TPanel
      Left = 422
      Top = 31
      Width = 332
      Height = 23
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 6
      object lblTitTct: TLabel
        Left = 3
        Top = 8
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Caption = 'Tipo de Cota'#231#227'o:'
      end
      object edtCodTct: TEditFocus
        Tag = 99
        Left = 88
        Top = 0
        Width = 45
        Height = 22
        Alignment = taLeftJustify
        AutoSize = False
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        OnExit = edtCodTctExit
        OnKeyPress = edtCodTctKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesTct: TEditFocus
        Left = 135
        Top = 0
        Width = 195
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
    object pnlBID: TPanel
      Left = 850
      Top = 1
      Width = 242
      Height = 80
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 10
      object Label25: TLabel
        Left = 0
        Top = -1
        Width = 108
        Height = 28
        Caption = 'Data Limite para Responder a Cota'#231#227'o:'
        WordWrap = True
      end
      object cxDBDateEdit1: TcxDBDateEdit
        Left = 113
        Top = 5
        DataBinding.DataField = 'COT_DTALIM'
        DataBinding.DataSource = dtsCotGer
        TabOrder = 0
        Width = 117
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 29
        Width = 242
        Height = 51
        Align = alBottom
        Caption = 'Cota'#231#227'o liberada para bid de compras?'
        TabOrder = 1
        object lblIntegrado: TLabel
          Left = 2
          Top = 35
          Width = 238
          Height = 14
          Align = alBottom
          Alignment = taCenter
          Caption = 'Pendente de Integra'#231#227'o'
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 131
        end
        object rdbNaoLiberado: TRadioButton
          Left = 9
          Top = 17
          Width = 98
          Height = 17
          Caption = 'N'#227'o Liberado'
          TabOrder = 0
          OnClick = rdbNaoLiberadoClick
        end
        object rdbLiberado: TRadioButton
          Left = 113
          Top = 17
          Width = 113
          Height = 17
          Caption = 'Liberado'
          TabOrder = 1
          OnClick = rdbLiberadoClick
        end
      end
    end
    object edtCodSolicitacaoVinculada: TEditFocus
      Tag = 99
      Left = 657
      Top = 54
      Width = 71
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 40
      TabOrder = 11
      OnKeyPress = edtCodSolicitacaoVinculadaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pagCotacao: TPageControl [3]
    Left = 0
    Top = 82
    Width = 1350
    Height = 599
    ActivePage = tabItens
    Align = alClient
    TabOrder = 3
    StyleElements = [seFont, seBorder]
    OnChange = pagCotacaoChange
    object tabItens: TTabSheet
      Caption = '&1- Itens'
      ImageIndex = 1
      object splGiro: TSplitter
        Left = 0
        Top = 470
        Width = 1342
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        AutoSnap = False
        Beveled = True
        Color = clYellow
        MinSize = 20
        ParentColor = False
        ResizeStyle = rsNone
        ExplicitTop = 200
        ExplicitWidth = 951
      end
      object splAplicacao: TSplitter
        Left = 0
        Top = 200
        Width = 1342
        Height = 5
        Cursor = crVSplit
        Align = alBottom
        AutoSnap = False
        Beveled = True
        Color = clYellow
        MinSize = 20
        ParentColor = False
        ResizeStyle = rsNone
        OnCanResize = splAplicacaoCanResize
        ExplicitTop = 131
        ExplicitWidth = 951
      end
      object pnlBotoesItens: TPanel
        Left = 0
        Top = 475
        Width = 1342
        Height = 95
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          1342
          95)
        object lblExiApli: TLabel
          Left = 754
          Top = 77
          Width = 158
          Height = 14
          Cursor = crHandPoint
          Caption = 'Ocultar Aplica'#231#227'o do Produto'
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold, fsUnderline]
          ParentColor = False
          ParentFont = False
          OnClick = lblExiApliClick
        end
        object BitBtnLocked1: TBitBtnLocked
          Left = 1476
          Top = 70
          Width = 77
          Height = 22
          Anchors = [akRight, akBottom]
          Cancel = True
          Caption = 'Cancela'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603
            015603015603FF00FF0000820000820000820000820000820000820000820000
            820000820000820000820156032DC6511DB236015603FF00FF000082011EF305
            27FB1337FB3052FC5F7DFEA1B4FFF2F6FFFFFFFFFFFFFF0000820156033FD96D
            30C956015603FF00FF0000820120FB0528FC1438FC3154FE607FFFA5B7FFF6FA
            FFFFFFFFFFFFFF000082015603015603015603015603FF00FF00008200008200
            0082000082000082000082000082000082000082000082000082FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF015603015603FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            01560341E07428AC47015603015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FF035A05015603FF00FFFF00FFFF00FF0156032DC45035CE5D188F2C015603FF
            00FFFF00FFFF00FFFF00FFFF00FF045F09188E2B015603FF00FFFF00FF015603
            0E8F1C19AB3122B53E035E07FF00FFFF00FFFF00FFFF00FFFF00FF05630A2DB7
            50015603FF00FFFF00FFFF00FF01560301560303650711A32216A42904600702
            5804015704045F080E78192FBC55015603FF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF0156030263050A98150FA01F0D891A108E1F1CA6342ABD4A015603FF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF01560301560305840C08
            8E110D971A0D971A015603FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FF015603015603015603015603FF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          ModalResult = 2
          TabOrder = 0
          Visible = False
          OnClick = btnSairClick
        end
        object pnlTailFixo: TPanel
          Left = 0
          Top = 0
          Width = 1342
          Height = 40
          Align = alTop
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 1
          object pnlTail: TPanel
            Left = 0
            Top = -1
            Width = 1355
            Height = 41
            BevelOuter = bvNone
            ParentBackground = False
            ParentColor = True
            TabOrder = 0
            object Label6: TLabel
              Left = 10
              Top = 15
              Width = 22
              Height = 14
              Alignment = taRightJustify
              Caption = 'Item:'
            end
            object Label9: TLabel
              Left = 462
              Top = 15
              Width = 58
              Height = 14
              Alignment = taRightJustify
              Caption = 'Quantidade:'
            end
            object btnInsPla: TSpeedButton
              Left = 711
              Top = 2
              Width = 29
              Height = 31
              Hint = 'Inserir itens de arquivo'
              Flat = True
              Glyph.Data = {
                F6060000424DF606000000000000360000002800000018000000180000000100
                180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFC76414E5B582DE9F63D4863FCB6D1F
                C25708BF4E01C76414FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFC96718F4DDC2F6
                E3CAF4E0C2F2D5B1F2CB9DC79E81A17360D98435CC6F20C55E0FC05204BD4C00
                BD4C00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFCC6918FFE3BDFCE3C0F7DCBAF4DAB6FADCB1F0D4AD0525F7FEDCA9EECC9EEB
                C592EABA7FCC96629A664DD57622C55D0DBF5003BD4C00BD4C00FF00FFFF00FF
                FF00FFFF00FFFF00FFAF581B9898C6F8E3CAF4DDC1F3DABCF2D7B6F2D5B10525
                F7F0D0A6F4D1A1F2CF9DF3CF99EEC7930525F7FACE8BE9BC80E5B06DE0A35CBD
                4D00FF00FFFF00FFFF00FFFF00FFFF00FFBB5F1B1B3AEE2544EF5066E2586BDE
                8089D39396CA0525F7D5C0B1F0CFA6EFCCA1F0CC99EDC7980525F7EBC48EEFC5
                89EEC587EFCA8EBD4D00FF00FFFF00FFFF00FF0E90C90E90C9CA691AACA0BDB2
                B5DC828EDA6E7EDC4F65E13651E50525F70A2AF30525F71A39EB2441E5495CD3
                0525F77E7FB88B87B0B29F9EC2A38CBD4D00FF00FFFF00FF0E90C94AB8E34CBB
                E6C76516E3C6B1FAEBD8F6E2C9F7E1C4F4DDC2F3DCBF0525F7FFE6ACF2D4AFBB
                ADB6AFA4B57E82C10525F7364DD52440DD2440E10E2DEEBD4D00FF00FF0E90C9
                76DDF87FD3F269C9EDCA6614E6C9B5FAEEDDF7E5D1F6E2CCF6E1C7F4DDC20525
                F7F2D8B8F2D7B4F0D4ADF0D0A9EFCFA40525F7FFD993FACF91F0C78EE3BA88BD
                4D00FF00FF0E90C984E3FC99DDF787D5F3AF561B193AF22646F35069EA596FE6
                828EDD979CD70525F7D8C9C1F2D9B7F2D5B2F0D3ADF0D0A70525F7FCD498EEC9
                97EEC792F0CC96BD4D00FF00FF0E90C992EBFFB4E9FBA5E1F8BC5E18B0A7C7B5
                BBED8392E66F82E55068E73753EA0525F70C2DF40525F71B3AEE2442E94A5EDA
                0525F77F82C48C8BBCB4A4ABDCC0A0BD4D00FF00FF0E90C996EDFFC5EFFFBFEB
                FEC96616FFF0DDFCF6EEFFF4D9F8EADAF7E7D5F7E3D00525F7F6DEC5F4DDC0BC
                B5C5B1ABC48086CB0525F74E62D53A52DC2441E50F2EEFBD4D00FF00FF0E90C9
                96EDFFC7F0FFCBF0FFC76516FAEFE2FBF3EBFAEFE2F8EADAFFEED4F7E7D40525
                F7F6E2C9FBE2BDFCE1B8FFE2B2F2D7B40525F7F0D1ABF0D0A5F0CFA1E6C197BD
                4D00FF00FF0E90C996EDFFC6F0FFCBF0FFC55F11F8EADCFBF6EEFBF3EBFBF3EB
                FFFAEAF8EAD80525F7FFF0D3F6E3CAF4E0C2F7DEBCF2D8B80525F7FFDDAAF4D3
                A6F4D1A1FAD8A4BD4D00FF00FF0E90C996EDFFC6F0FFCBF0FFBF4F02CA691CCE
                762BD18039D78A48DE9857BF8E6F0525F7F0C695EFCFACF2D7B8F7DCBAF3DCBD
                0525F7FFE7BDF3DCB8F3D8B2F3DCB5BD4D00FF00FF0E90C996EDFFC6F0FFCBF0
                FFBD4B00BC4700BB4600BB4600BA4300BA4300BC4700BD4B00BA4300BA4300BA
                4300BA4300BA4300BA4300BA4300BA4300BA4300BA4300BD4D00FF00FF0E90C9
                96EDFFC6F0FFCBF0FFBD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4C00BD4B
                00BC4A00BC4A00BC4A00BC4700BC4700C04800BA4300BB4600BC4A00BD4C00BD
                4D00FF00FF0E90C996EDFFC6F0FFCBF0FFBD4C00BD4C00BD4C00BD4C00BD4C00
                BD4C00BD4C00BD4C00BD4C00BD4C00BD4D00BD4D00BD4D00BD4D00BD4C00BD4C
                00BD4C00BD4B00BD4B00FF00FF0E90C99DF0FFD1F6FFD0F2FFB5EDFF81E6FE6B
                E3FF6FE6FF76EAFF0E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C966D1F064C1E55BBC
                E253BAE243B8E13AB7E23BBAE551CEF00E90C9FF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C9
                73CBEA91DCF092E1F68BE1F87DDEF86BDAF458D3F044C4E90E90C9FF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FF0E90C967CEED6FDAF666DCF75FDAF85CD8F64BC9EB0E90C9
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0E90C90E90C90E90C90E90C90E
                90C90E90C9FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
                FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
                FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              ParentShowHint = False
              ShowHint = True
              OnClick = btnInsPlaClick
            end
            object edtDesIte: TEditFocus
              Tag = 99
              Left = 100
              Top = 9
              Width = 349
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              Color = 16768952
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 57
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
            object edtQtdIte: TEditFocus
              Tag = 99
              Left = 522
              Top = 9
              Width = 87
              Height = 22
              Alignment = taRightJustify
              CharCase = ecUpperCase
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ParentFont = False
              TabOrder = 2
              Text = '0,00'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtCodIte: TEditFocus
              Tag = 99
              Left = 34
              Top = 9
              Width = 65
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 5
              TabOrder = 0
              OnEnter = edtCodIteEnter
              OnKeyPress = edtCodIteKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 5
              TipoTexto = ttAlfanumerico
            end
            object pnlSimilar: TPanel
              Left = 615
              Top = 12
              Width = 90
              Height = 20
              BevelOuter = bvNone
              Font.Charset = ANSI_CHARSET
              Font.Color = 8404992
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              object shpSimilar: TShape
                Left = 3
                Top = 1
                Width = 14
                Height = 14
                Brush.Color = clNavy
              end
              object lblSimilar: TLabel
                Left = 23
                Top = 1
                Width = 53
                Height = 14
                Caption = 'Item Similar'
                Font.Charset = ANSI_CHARSET
                Font.Color = clNavy
                Font.Height = 14
                Font.Name = 'Arial'
                Font.Pitch = fpVariable
                Font.Style = []
                ParentFont = False
              end
            end
            object btnCarregaPedidosVenda: TBitBtnLocked
              Left = 743
              Top = 8
              Width = 149
              Height = 22
              Caption = 'Carregar Prod. Vendidos'
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
                96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
                609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
                D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
                9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
                95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
                8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
                A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
                A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
                E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
                B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
                ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
                E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
                BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
                27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
                EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
                C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
                C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
                8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
                CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
                D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
                FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
                CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
                68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
                00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
              TabOrder = 4
              OnClick = btnCarregaPedidosVendaClick
            end
          end
        end
        object btnIncluir: TBitBtnLocked
          Left = 15
          Top = 47
          Width = 71
          Height = 22
          Caption = '&Incluir'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
            609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
            D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
            9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
            95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
            8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
            A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
            A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
            E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
            B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
            ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
            E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
            BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
            27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
            EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
            C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
            C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
            8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
            CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
            D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
            FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
            CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
            68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 2
          OnClick = btnIncluirClick
        end
        object btnExcluir: TBitBtnLocked
          Left = 14
          Top = 69
          Width = 72
          Height = 22
          Caption = 'E&xcluir'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
            00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
            00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
            DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
            006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
            16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
            20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
            6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
            00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
            00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
            E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 3
          OnClick = btnExcluirClick
        end
        object btnGiroEst: TBitBtnLocked
          Left = 225
          Top = 46
          Width = 147
          Height = 22
          Caption = '[F6] Giro de &Estoque'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
            609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
            D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
            9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
            95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
            8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
            A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
            A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
            E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
            B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
            ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
            E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
            BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
            27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
            EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
            C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
            C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
            8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
            CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
            D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
            FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
            CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
            68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 4
          OnClick = btnGiroEstClick
        end
        object btnImporta: TBitBtnLocked
          Left = 372
          Top = 46
          Width = 149
          Height = 22
          Caption = '[F7] Importar Requisi'#231#227'o'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
            FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
            00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
            F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
            00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
            F033777777777337F73309999990FFF0033377777777FFF77333099999000000
            3333777777777777333333399033333333333337773333333333333903333333
            3333333773333333333333303333333333333337333333333333}
          NumGlyphs = 2
          TabOrder = 5
          OnClick = btnImportaClick
        end
        object btnSimilares: TBitBtnLocked
          Left = 98
          Top = 68
          Width = 127
          Height = 23
          Caption = '[ F11 ] Similares'
          TabOrder = 6
          OnClick = btnSimilaresClick
        end
        object btnSemelhantes: TBitBtnLocked
          Left = 225
          Top = 68
          Width = 147
          Height = 23
          Caption = '[ F9 ] Semelhantes'
          TabOrder = 7
          OnClick = btnSemelhantesClick
        end
        object btnPrepTE: TBitBtnLocked
          Left = 372
          Top = 68
          Width = 149
          Height = 22
          Caption = '[F8] Prepara Gera'#231#227'o TE'
          NumGlyphs = 2
          TabOrder = 8
          OnClick = btnPrepTEClick
        end
        object btnMarGerPed: TBitBtnLocked
          Left = 521
          Top = 68
          Width = 219
          Height = 22
          Caption = '[Alt + F5] Marca todos como "Gerou Pedido"'
          NumGlyphs = 2
          TabOrder = 9
          OnClick = btnMarGerPedClick
        end
        object btnMarDesGerPed: TBitBtnLocked
          Left = 521
          Top = 46
          Width = 219
          Height = 22
          Caption = '[F5] Marca / Desmarca "Gerou Pedido"'
          NumGlyphs = 2
          TabOrder = 10
          OnClick = btnMarDesGerPedClick
        end
        object btnDesGerPed: TBitBtnLocked
          Left = 741
          Top = 46
          Width = 241
          Height = 22
          Caption = '[Alt + F6] Desmarca todos como "Gerou Pedido"'
          NumGlyphs = 2
          TabOrder = 11
          OnClick = btnDesGerPedClick
        end
        object btnCompCusto: TBitBtnLocked
          Left = 98
          Top = 46
          Width = 127
          Height = 22
          Caption = '[F4] Compos. Custo'
          TabOrder = 12
          OnClick = btnCompCustoClick
        end
        object btnEstoqueDasLojas: TBitBtnLocked
          Left = 983
          Top = 46
          Width = 149
          Height = 22
          Caption = 'Estoque das Lojas'
          NumGlyphs = 2
          TabOrder = 13
          OnClick = btnEstoqueDasLojasClick
        end
        object btnMarcarDesmarcarExcluir: TBitBtnLocked
          Left = 1133
          Top = 46
          Width = 149
          Height = 22
          Caption = 'Marca / Desmarca Excluir'
          NumGlyphs = 2
          TabOrder = 14
          OnClick = btnMarcarDesmarcarExcluirClick
        end
      end
      object pnlGiro: TPanel
        Left = 0
        Top = 205
        Width = 1342
        Height = 205
        Align = alBottom
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        Visible = False
        object cxImage1: TcxImage
          Left = 912
          Top = 160
          TabOrder = 0
          Height = 100
          Width = 140
        end
      end
      object pnlAplicacao: TPanel
        Left = 0
        Top = 410
        Width = 1342
        Height = 60
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 2
        object pnlTitAplic: TPanel
          Left = 0
          Top = 0
          Width = 1342
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Aplica'#231#227'o'
          Color = clBlack
          Ctl3D = True
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentCtl3D = False
          ParentFont = False
          TabOrder = 0
        end
        object dbeAplica: TDBMemoFocus
          Left = 0
          Top = 18
          Width = 1342
          Height = 42
          Align = alClient
          DataField = 'APLICA'
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
      end
      object lblReq: TPanel
        Left = 0
        Top = 186
        Width = 1342
        Height = 14
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Requisi'#231#245'es: '
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold]
        ParentBackground = False
        ParentColor = True
        ParentFont = False
        TabOrder = 3
        Visible = False
      end
      object cxgItens: TcxGrid
        Left = 0
        Top = 0
        Width = 1342
        Height = 156
        Align = alClient
        TabOrder = 4
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxbItens: TcxGridDBTableView
          OnKeyDown = cxbItensKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCustomDrawCell = cxbItensCustomDrawCell
          OnFocusedRecordChanged = cxbItensFocusedRecordChanged
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoSortByDisplayText, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems.OnSummary = cxbItensDataControllerSummaryFooterSummaryItemsSummary
          DataController.Summary.FooterSummaryItems = <
            item
              Kind = skSum
              FieldName = 'QTDITE'
              Column = cxbItensQTDITE
            end
            item
              Kind = skSum
              FieldName = 'PRCLIQ'
              Column = cxbItensPRCLIQ
            end
            item
              Kind = skSum
              FieldName = 'PRECUS'
              Column = cxbItensPRECUS
            end
            item
              Kind = skSum
              FieldName = 'IMPULT'
              Column = cxbItensIMPULT
            end
            item
              Kind = skSum
              FieldName = 'PREULT'
              Column = cxbItensPREULT
            end
            item
              Kind = skSum
              FieldName = 'PESOIT'
              Column = cxbItensPESOIT
            end>
          DataController.Summary.SummaryGroups = <>
          DataController.OnCompare = cxbItensDataControllerCompare
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.NoDataToDisplayInfoText = 'Nehum item incluido'
          OptionsView.Footer = True
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle3
          object cxbItensEXCLUI: TcxGridDBColumn
            Caption = 'Excluir'
            DataBinding.FieldName = 'EXCLUI'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Properties.OnChange = cxbItensEXCLUIPropertiesChange
            HeaderAlignmentHorz = taCenter
          end
          object cxbItensGERPED: TcxGridDBColumn
            Caption = 'Gerou Pedido'
            DataBinding.FieldName = 'GERPED'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Properties.OnChange = cxbItensGERPEDPropertiesChange
            HeaderAlignmentHorz = taCenter
            Width = 75
          end
          object cxbItensCODITE: TcxGridDBColumn
            Caption = 'C'#243'd. Item'
            DataBinding.FieldName = 'CODITE'
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 70
            OnHeaderClick = cxbItensCODITEHeaderClick
          end
          object cxbItensCODFAB: TcxGridDBColumn
            Caption = 'C'#243'digo F'#225'brica'
            DataBinding.FieldName = 'CODFAB'
            Options.Editing = False
            Width = 135
          end
          object cxbItensCODGRU: TcxGridDBColumn
            Caption = 'C'#243'd. Grupo'
            DataBinding.FieldName = 'CODGRU'
            Options.Editing = False
            Width = 69
          end
          object cxbItensDESITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o do Item'
            DataBinding.FieldName = 'DESITE'
            Options.Editing = False
            Width = 313
          end
          object cxbItensREFERE: TcxGridDBColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'REFERE'
            Options.Editing = False
            Width = 105
          end
          object cxbItensQTDITE: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Width = 100
          end
          object cxbItensUNIMED: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'UNIMED'
            Visible = False
            Options.Editing = False
            Width = 120
          end
          object cxbItensDTAULT: TcxGridDBColumn
            Caption = 'Data '#218'lt.Com.'
            DataBinding.FieldName = 'DTAULT'
            Options.Editing = False
            Width = 75
          end
          object cxbItensFORULT: TcxGridDBColumn
            Caption = 'Fornecedor '#218'ltima Compra'
            DataBinding.FieldName = 'FORULT'
            Options.Editing = False
            Width = 149
          end
          object cxbItensPREULT: TcxGridDBColumn
            Caption = 'Unit.'#218'lt.Com.'
            DataBinding.FieldName = 'PREULT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 73
          end
          object cxbItensIMPULT: TcxGridDBColumn
            Caption = #218'lt.Com.+Imp'
            DataBinding.FieldName = 'IMPULT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 73
          end
          object cxbItensDESMAR: TcxGridDBColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'DESMAR'
            Options.Editing = False
            Width = 200
          end
          object cxbItensCODSEM: TcxGridDBColumn
            Caption = 'Semelhantes'
            DataBinding.FieldName = 'CODSEM'
            Options.Editing = False
            Width = 287
          end
          object cxbItensSALDOS: TcxGridDBColumn
            Caption = 'Saldo F'#237'sico'
            DataBinding.FieldName = 'SALDOS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 65
          end
          object cxbItensSALDIS: TcxGridDBColumn
            Caption = 'Saldo Dispon'#237'vel'
            DataBinding.FieldName = 'SALDIS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            MinWidth = 90
            Options.Editing = False
          end
          object cxbItensQTDREQ: TcxGridDBColumn
            Caption = 'Qtd. Requis. (*)'
            DataBinding.FieldName = 'QTDREQ'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Options.Editing = False
            Width = 85
          end
          object cxbItensSALDOSLOJASGIROS: TcxGridDBColumn
            Caption = 'Saldo das Empresas do Giro'
            DataBinding.FieldName = 'SALDOS_LOJAS_GIROS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 156
          end
          object cxbItensDIAEST: TcxGridDBColumn
            Caption = 'Dias Estoque'
            DataBinding.FieldName = 'DIAEST'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
          end
          object cxbItensDIASUG: TcxGridDBColumn
            Caption = 'Dias Estoque Qtd. Comprada'
            DataBinding.FieldName = 'DIASUG'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 150
          end
          object cxbItensPESOIT: TcxGridDBColumn
            Caption = 'Peso'
            DataBinding.FieldName = 'PESOIT'
            Options.Editing = False
            Width = 20
          end
          object cxbItensMEDIA: TcxGridDBColumn
            Caption = 'M'#233'dia Vendas'
            DataBinding.FieldName = 'MEDVEN'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DecimalPlaces = 2
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.Nullstring = '0'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Options.FilteringAddValueItems = False
            Width = 103
          end
          object cxbItensPRCLIQ: TcxGridDBColumn
            Caption = 'Pre'#231'o Comp. Liq.'
            DataBinding.FieldName = 'PRCLIQ'
            Options.Editing = False
            Width = 28
          end
          object cxbItensPRECUS: TcxGridDBColumn
            Caption = 'Pre'#231'o de Cus. Unit.'
            DataBinding.FieldName = 'PRECUS'
            Options.Editing = False
            Width = 20
          end
          object cxbItensITESIM: TcxGridDBColumn
            Caption = 'Item Similar'
            DataBinding.FieldName = 'ITESIM'
            Visible = False
            VisibleForCustomization = False
          end
          object cxbItensORDITE: TcxGridDBColumn
            Caption = 'Ordem Item'
            DataBinding.FieldName = 'ORDITE'
            Visible = False
            VisibleForCustomization = False
          end
          object cxbItensSALSIM: TcxGridDBColumn
            Caption = 'Saldo Similar'
            DataBinding.FieldName = 'SALSIM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 98
          end
        end
        object cxgItensLevel1: TcxGridLevel
          GridView = cxbItens
        end
      end
      object pnlPesoTotal: TPanel
        Left = 0
        Top = 156
        Width = 1342
        Height = 30
        Align = alBottom
        Color = 16770261
        ParentBackground = False
        TabOrder = 5
        object btnCfgGriItens: TBitBtnLocked
          Left = 4
          Top = 6
          Width = 165
          Height = 19
          Caption = 'Confi&gura colunas'
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000010000000A09070663583F36EC573D35EC1911105A000000020000
            00090000000E0000000F00000010000000100000001100000011000000110000
            00130000001A0E0A09745D4C44FEC8A995FFC9A996FF553C34E900000008815A
            4EC0B37E6CFFB37D6AFFB37E6CFFB27D6BFFB27C69FFB17D6AFFBE9081FFD1B6
            ADFF947E77FF6D594FFFD6B6A1FFD4B6A1FFDBC7B9FF584037EC0000000CB581
            6FFFFDFBF9FFFBF5F2FFF9F4F0FFF5EFEBFFF1EBE7FFEEE7E3FFECE4E0FFADA2
            9DFF79645AFFD8BBAAFFD8BBA8FFE6D4C7FF8C766CFE1D15125D0000000CB884
            71FFFDFBFAFFF5EBE4FFEBE1DAFFA29089FF6A534BFF4B332BFF574239FF856F
            64FFDCC1B2FFDCC2B0FFEAD7CCFF978177FF2219166F000000080000000BB886
            75FFFCFAFAFFEAE1DBFF816A61FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
            B8FFDFC7B7FFE9DACFFF9B857BFFA88F87FF00000018000000010000000ABA89
            78FFFAF8F7FFAC9A92FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
            BDFFE2CEBFFFA08A80FFBEB1ABFFD6BBB3FF000000110000000000000009BD8C
            7AFFF8F7F6FF8E7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
            BFFFD1B9ABFF82675DFFEFE9E5FFC4998AFF0000000F0000000000000009C08F
            7FFFF8F7F6FF8C7165FFB7A299FFBFAFA7FFEEE6E1FFBBAAA1FFAF9B92FFE6D1
            C3FFE6D2C7FF7E6459FFF2EDE9FFBB8A77FF0000000E0000000000000008C394
            84FFFAFAF9FF9D867BFFC7B8B0FFF6F0EAFFF8F1ECFFEAE1DCFF71574DFFE7D4
            C6FFD2C0B8FF8C7369FFF5F0EDFFBC8D7AFF0000000D0000000000000007C597
            87FFFDFDFCFFF8F3EEFFF9F3EFFFFAF4EFFFF7F0ECFFA89791FF937C72FFEEE0
            D8FFB09C92FFB9A8A0FFF9F4F1FFC08F7EFF0000000D0000000000000006C79A
            8CFFFEFEFEFFFAF6F3FFFAF5F3FFF9F4F0FFAB9B93FF8F7A72FFCABAB2FFB6A2
            97FFA38C81FFF4ECE8FFFCF8F6FFC39282FF0000000C0000000000000006CA9E
            8EFFFFFEFEFFFBF7F4FFFBF6F4FFF9F4F2FFAC9589FF987D6FFFA58E85FFC6B6
            AFFFF6EFEAFFF9F4EFFFFDFAF8FFC49687FF0000000B0000000000000005CCA3
            91FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFAF5F3FFF8F3F1FFF8F3F1FFFAF4
            F1FFFCF6F2FFFBF6F1FFFDFBF9FFC79A8BFF0000000A0000000000000004CEA4
            95FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
            FDFFFEFDFDFFFEFDFDFFFEFDFCFFC99E8EFF0000000900000000000000029A7B
            6FC0CFA696FFCFA696FFCEA695FFCEA595FFCEA595FFCFA494FFCDA494FFCEA3
            93FFCCA293FFCDA292FFCBA292FF97776BC20000000600000000}
          TabOrder = 0
          OnClick = btnCfgGriItensClick
        end
      end
    end
    object tabFornecedores: TTabSheet
      Caption = '&2- Fornecedores'
      object Panel2: TPanel
        Left = 0
        Top = 541
        Width = 1342
        Height = 29
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object btnExpArq: TBitBtnLocked
          Left = 162
          Top = 5
          Width = 111
          Height = 22
          Caption = '&Exportar Arquivo'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
            333333333333337FF3333333333333903333333333333377FF33333333333399
            03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
            99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
            99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
            03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
            33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
            33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
            3333777777333333333333333333333333333333333333333333}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = btnExpArqClick
        end
        object btnImpArq: TBitBtnLocked
          Left = 273
          Top = 5
          Width = 111
          Height = 22
          Caption = '&Importar Arquivo'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            33333333333FFFFFFFFF333333000000000033333377777777773333330FFFFF
            FFF03333337F333333373333330FFFFFFFF03333337F3FF3FFF73333330F00F0
            00F03333F37F773777373330330FFFFFFFF03337FF7F3F3FF3F73339030F0800
            F0F033377F7F737737373339900FFFFFFFF03FF7777F3FF3FFF70999990F00F0
            00007777777F7737777709999990FFF0FF0377777777FF37F3730999999908F0
            F033777777777337F73309999990FFF0033377777777FFF77333099999000000
            3333777777777777333333399033333333333337773333333333333903333333
            3333333773333333333333303333333333333337333333333333}
          NumGlyphs = 2
          TabOrder = 2
          OnClick = btnImpArqClick
        end
        object btnMarDes: TBitBtnLocked
          Left = 4
          Top = 5
          Width = 158
          Height = 22
          Caption = '[ENTER] Marca / Desmarca'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          TabOrder = 0
          OnClick = btnMarDesClick
        end
        object btnForPre: TBitBtnLocked
          Left = 384
          Top = 5
          Width = 138
          Height = 22
          Caption = '&Pre'#231'os do Fornecedor'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
            83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
            DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
            AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
            00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
            E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
            0066000066000066000066000066000066000066000066000066000066000066
            00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
            3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
            0066000066000066000066000066000066000066000066000066000066000066
            00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
            ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
            CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
            00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
            F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
            0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
            D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
            2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
            43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
            DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
            FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
            0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
            82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 3
          OnClick = btnForPreClick
        end
        object btnIncForGupos: TBitBtnLocked
          Left = 523
          Top = 5
          Width = 339
          Height = 22
          Caption = '[ F5 ] Incluir fornecedores pelos grupos de produtos da cota'#231#227'o'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
            609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
            D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
            9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
            95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
            8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
            A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
            A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
            E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
            B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
            ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
            E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
            BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
            27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
            EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
            C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
            C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
            8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
            CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
            D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
            FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
            CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
            68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 4
          OnClick = btnIncForGuposClick
        end
      end
      object pnlTailFornecedores: TPanel
        Left = 0
        Top = 487
        Width = 1342
        Height = 54
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 1
        object pnlObservacao: TPanel
          Left = 655
          Top = 0
          Width = 687
          Height = 54
          Align = alRight
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          object Label24: TLabel
            Left = 23
            Top = 24
            Width = 63
            Height = 14
            Alignment = taRightJustify
            Caption = 'Observa'#231#227'o:'
          end
          object dbeObsCmp: TDBMemoFocus
            Left = 92
            Top = 6
            Width = 593
            Height = 47
            DataField = 'OBSERV'
            DataSource = dtsCotCfo
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            StringQuebra = '<<csq>>'
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 6
          Width = 687
          Height = 36
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 1
          object lblCliFor: TLabel
            Left = 6
            Top = 22
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fornecedor:'
          end
          object edtCodFor: TEditFocus
            Tag = 99
            Left = 71
            Top = 14
            Width = 56
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            MaxLength = 8
            TabOrder = 0
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
            Left = 128
            Top = 14
            Width = 361
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
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
          object btnIncluiFornecedor: TBitBtnLocked
            Left = 494
            Top = 14
            Width = 71
            Height = 22
            Caption = '&Incluir'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              96675E9F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F609F6F
              609F6F609F6F60FF00FFFF00FFFF00FF99695FF6E0BFF4DDB8F3DAB4F3D7ADF2
              D5A7F0D3A3F0D09EEECC99EECA93EDC990EDC68C9F6F60FF00FFFF00FFFF00FF
              9D6C60F6E3C6F6E1C1F4DDBBF3DCB4008100F2D5AAF0D3A4F0CF9FEFCC99EFCB
              95EEC9909F6F60FF00FFFF00FFFF00FFA16E60F7E6CEF6E5C7F4E1C100810000
              8100008100F3D5ABF0D3A5EFD19FEFCE9AEFCB969F6F60FF00FFFF00FFFF00FF
              A67262F8EAD4F7E7CE008100307A2A5F924B00810050883CF2D5ABF0D3A5F0D0
              A0EFCF9C9F6F60FF00FFFF00FFFF00FFAB7663FAEEDAFAEBD5008100EFE2C2F6
              E2C2A7B883008100008100EDD4A9F0D4A6F0D1A19F6F60FF00FFFF00FFFF00FF
              B07864FAF0E2FAEEDCF8EBD5F8E9D0F7E6CAF6E3C5E6D8B4008100008100F2D7
              ADF2D4A79F6F60FF00FFFF00FFFF00FFB57D64FCF3E7FBF0E3FAEFDDFAEDD8F7
              E9D1F8E6CBF6E3C5F6E1C0F4DEBAF4DAB5F3D7AD9F6F60FF00FFFF00FFFF00FF
              BB8065FCF7EDD58127D58127D58127D58127D58127D58127D58127D58127D581
              27F3DAB69F6F60FF00FFFF00FFFF00FFC08366FCF8F3FCF7EFFCF4EAFBF2E5FB
              EFDEF8EDD9F8EBD4F8E7CEF7E3C7F6E1C2F4DEBB9F6F60FF00FFFF00FFFF00FF
              C48767FEFBF8FEFAF3FEF7EFFCF4EAFBF2E6FAEFE0F8EDDAF8EAD4F7E9CFF7E5
              C9F6E2C49F6F60FF00FFFF00FFFF00FFC98967FEFCFBD58127D58127D58127D5
              8127D58127D58127D58127D58127D58127F7E5CA9F6F60FF00FFFF00FFFF00FF
              CC8B68FFFFFFFFFEFCFEFCFAFEFBF4FEF8F0FCF6EDFCF4E7FAF2E2FAEFDCF8ED
              D7F8EAD19F6F60FF00FFFF00FFFF00FFCF8E68FFFFFFFFFFFFFFFFFCFFFCFAFE
              FBF6FEF8F0FCF7EEFBF4E9FBF2E3FBEFDDF8EDD89F6F60FF00FFFF00FFFF00FF
              CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E68CF8E
              68CF8E68CF8E68FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 2
            OnClick = btnIncluiFornecedorClick
          end
          object btnExcluiFornecedor: TBitBtnLocked
            Left = 571
            Top = 14
            Width = 72
            Height = 22
            Caption = '&Excluir'
            Glyph.Data = {
              36030000424D3603000000000000360000002800000010000000100000000100
              18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E0000
              6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001DE80010DC00006EFF00FFFF
              00FFFF00FFFF00FF00006E0004E20008E700006EFF00FFFF00FFFF00FFFF00FF
              00006E001AE2001FEB0010D900006EFF00FFFF00FF00006E0005DF0009EB0003
              DB00006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E001ADF0020EB0013DC00
              006E00006E0005E2000BEB0004DA00006EFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FF00006E001BDF0022EB0012E60008EA0009EB0004DF00006EFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E001BE300
              16EB0011EB000ADF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FF00006E0021E7001EEB001AEB0017DF00006EFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00006E062DE30430EB00
              20E2001EE20027EB0019DF00006EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FF00006E0C35E40E3CEB052BDC00006E00006E001FDC002AEB001CDF0000
              6EFF00FFFF00FFFF00FFFF00FFFF00FF00006E1442E41645EB092ED900006EFF
              00FFFF00FF00006E0020D9012CEB001FE200006EFF00FFFF00FFFF00FFFF00FF
              00006E1C4BE71037DB00006EFF00FFFF00FFFF00FFFF00FF00006E0022DC0027
              E400006EFF00FFFF00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FF00006E00006EFF00FFFF00FFFF00FFFF00FFFF00FF
              FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
              FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
              00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
            TabOrder = 3
            OnClick = btnExcluiFornecedorClick
          end
        end
      end
      object cxgFornecedores: TcxGrid
        Left = 0
        Top = 0
        Width = 1342
        Height = 487
        Align = alClient
        TabOrder = 2
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxvFornecedores: TcxGridDBTableView
          OnKeyDown = cxvFornecedoresKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellClick = cxvFornecedoresCellClick
          OnCustomDrawCell = cxvFornecedoresCustomDrawCell
          OnFocusedRecordChanged = cxvFornecedoresFocusedRecordChanged
          DataController.DataSource = dtsCotCfo
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.ShowEditButtons = gsebAlways
          OptionsView.DataRowHeight = 19
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle3
          object cxvFornecedoresCODFOR: TcxGridDBColumn
            Caption = 'C'#243'digo do Fornecedor'
            DataBinding.FieldName = 'COT_CODFOR'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 136
          end
          object cxvFornecedoresNOMFOR: TcxGridDBColumn
            Caption = 'Nome do Fornecedor'
            DataBinding.FieldName = 'NOMFOR'
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 515
          end
          object cxvFornecedoresMARCADO: TcxGridDBColumn
            DataBinding.FieldName = 'MARCADO'
            Visible = False
            Options.Editing = False
          end
          object cxvFornecedoresCOT_IMGAPI: TcxGridDBColumn
            Caption = 'API'
            DataBinding.FieldName = 'COT_IMGAPI'
            PropertiesClassName = 'TcxImageProperties'
            Properties.FitMode = ifmNormal
            Properties.GraphicClassName = 'TdxPNGImage'
            Visible = False
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 145
          end
          object cxvFornecedoresACTAPI: TcxGridDBColumn
            Caption = 'A'#231#245'es API'
            Visible = False
            OnGetProperties = cxvFornecedoresACTAPIGetProperties
            Options.Editing = False
            Options.Filtering = False
            Width = 75
          end
          object cxvFornecedoresCOT_STAAPI: TcxGridDBColumn
            Caption = 'Situa'#231#227'o API'
            DataBinding.FieldName = 'COT_STAAPI'
            Visible = False
            OnGetDisplayText = cxvFornecedoresCOT_STAAPIGetDisplayText
            Options.Editing = False
            Options.Filtering = False
            Width = 130
          end
          object cxvFornecedoresCOT_ANCORA: TcxGridDBColumn
            Caption = 'Ancora'
            DataBinding.FieldName = 'COT_ANCORA'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ImageAlign = iaRight
            Properties.Images = cxImageList1
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 0
              end
              item
                ImageIndex = 1
                Value = 1
              end
              item
                ImageIndex = 2
                Value = 2
              end
              item
                ImageIndex = 3
                Value = 3
              end
              item
                ImageIndex = 4
                Value = 4
              end
              item
                ImageIndex = 5
                Value = 5
              end
              item
                ImageIndex = 6
                Value = 8
              end>
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 43
          end
          object cxvFornecedoresCOT_PITSTO: TcxGridDBColumn
            Caption = 'Pit Stop'
            DataBinding.FieldName = 'COT_PITSTO'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ImageAlign = iaRight
            Properties.Images = cxImageList1
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 0
              end
              item
                ImageIndex = 1
                Value = 1
              end
              item
                ImageIndex = 2
                Value = 2
              end
              item
                ImageIndex = 3
                Value = 3
              end
              item
                ImageIndex = 4
                Value = 4
              end
              item
                ImageIndex = 5
                Value = 5
              end
              item
                ImageIndex = 3
                Value = 6
              end
              item
                ImageIndex = 4
                Value = 7
              end
              item
                ImageIndex = 6
                Value = 8
              end>
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 43
          end
          object cxvFornecedoresCOT_SKYPEC: TcxGridDBColumn
            Caption = 'Sky'
            DataBinding.FieldName = 'COT_SKYPEC'
            PropertiesClassName = 'TcxImageComboBoxProperties'
            Properties.Alignment.Horz = taCenter
            Properties.ImageAlign = iaRight
            Properties.Images = cxImageList1
            Properties.Items = <
              item
                ImageIndex = 0
                Value = 0
              end
              item
                ImageIndex = 1
                Value = 1
              end
              item
                ImageIndex = 2
                Value = 2
              end
              item
                ImageIndex = 3
                Value = 3
              end
              item
                ImageIndex = 4
                Value = 4
              end
              item
                ImageIndex = 5
                Value = 5
              end
              item
                ImageIndex = 6
                Value = 8
              end>
            Visible = False
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 43
          end
          object cxvFornecedoresEMAENV: TcxGridDBColumn
            Caption = 'Email enviado?'
            DataBinding.FieldName = 'EMA_EMAENV'
            OnGetDisplayText = cxvFornecedoresEMAENVGetDisplayText
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 81
          end
          object cxvFornecedoresDTAENV: TcxGridDBColumn
            Caption = 'Data/Hora do envio'
            DataBinding.FieldName = 'EMA_DTAENV'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 110
          end
          object cxvFornecedoresENVDES: TcxGridDBColumn
            Caption = 'Destinat'#225'rios utilizados'
            DataBinding.FieldName = 'EMA_DESTIN'
            Options.Editing = False
            Width = 224
          end
          object cxvFornecedoresOBSERV: TcxGridDBColumn
            Caption = 'Observa'#231#227'o'
            DataBinding.FieldName = 'OBSERV'
            Width = 250
          end
          object cxvFornecedoresINIINT: TcxGridDBColumn
            DataBinding.FieldName = 'COT_INIINT'
            Visible = False
            Options.Editing = False
          end
        end
        object cxgFornecedoresLevel1: TcxGridLevel
          GridView = cxvFornecedores
        end
      end
    end
    object tabCotForIte: TTabSheet
      Caption = '&3- Cota'#231#227'o por Fornecedor'
      ImageIndex = 2
      object pnlHeader: TPanel
        Left = 0
        Top = 0
        Width = 1342
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object Fornecedor: TLabel
          Left = 8
          Top = 16
          Width = 65
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Fornecedor:'
        end
        object Label7: TLabel
          Left = 8
          Top = 39
          Width = 65
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Data Entrega:'
        end
        object Label8: TLabel
          Left = 160
          Top = 39
          Width = 137
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Condi'#231#227'o de Pagamento:'
        end
        object dbeDtaEnt: TDBEditFocus
          Tag = 99
          Left = 75
          Top = 31
          Width = 78
          Height = 22
          DataField = 'COT_DTAENT'
          DataSource = dtsCotCfo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          OnExit = dbeDtaEntExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeConPag: TDBEditFocus
          Tag = 99
          Left = 299
          Top = 31
          Width = 614
          Height = 22
          DataField = 'COT_CONPAG'
          DataSource = dtsCotCfo
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object cmbCodFor: TComboBoxFocus
          Left = 75
          Top = 8
          Width = 838
          Height = 22
          Style = csDropDownList
          TabOrder = 0
          OnChange = cmbCodForChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
      end
      object cxgItensFornec: TcxGrid
        Left = 0
        Top = 60
        Width = 1342
        Height = 446
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxbItensFornec: TcxGridDBBandedTableView
          OnKeyDown = cxbItensFornecKeyDown
          OnKeyPress = cxbItensFornecKeyPress
          Navigator.Buttons.CustomButtons = <>
          OnFocusedItemChanged = cxbItensFornecFocusedItemChanged
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          DataController.OnCompare = cxbItensFornecDataControllerCompare
          DataController.OnDataChanged = cxbItensFornecDataControllerDataChanged
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracImmediately
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle3
          Bands = <
            item
              FixedKind = fkLeft
              Width = 501
            end
            item
              Width = 1099
            end>
          object cxbItensFornecCODITE: TcxGridDBBandedColumn
            Caption = 'C'#243'd.Item'
            DataBinding.FieldName = 'CODITE'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 64
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbItensFornecCODFAB: TcxGridDBBandedColumn
            Caption = 'C'#243'digo F'#225'brica'
            DataBinding.FieldName = 'CODFAB'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            Options.Editing = False
            Width = 131
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbItensFornecDESITE: TcxGridDBBandedColumn
            Caption = 'Descri'#231#227'o do Item'
            DataBinding.FieldName = 'DESITE'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            Options.Editing = False
            Width = 306
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbItensFornecREFERE: TcxGridDBBandedColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'REFERE'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 100
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbItensFornecDESMAR: TcxGridDBBandedColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'DESMAR'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            Options.Editing = False
            Width = 181
            Position.BandIndex = 1
            Position.ColIndex = 14
            Position.RowIndex = 0
          end
          object cxbItensFornecQTDITE: TcxGridDBBandedColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'QTDITE'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 95
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbItensFornecVALUNI: TcxGridDBBandedColumn
            Caption = 'Valor Unit'#225'rio'
            DataBinding.FieldName = 'VALUNI01'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbItensFornecVALUNIPropertiesValidate
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 69
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbItensFornecIPIENT: TcxGridDBBandedColumn
            Caption = '% IPI'
            DataBinding.FieldName = 'IPIENT01'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 52
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbItensFornecSUBSTI: TcxGridDBBandedColumn
            Caption = '% Subst.'
            DataBinding.FieldName = 'SUBSTI01'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 52
            Position.BandIndex = 1
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxbItensFornecFREENT: TcxGridDBBandedColumn
            Caption = '% Frete'
            DataBinding.FieldName = 'FREENT01'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Position.BandIndex = 1
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxbItensFornecALQCBS: TcxGridDBBandedColumn
            Caption = '% CBS'
            DataBinding.FieldName = 'ALQCBS01'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Position.BandIndex = 1
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxbItensFornecALQIBS: TcxGridDBBandedColumn
            Caption = '% IBS'
            DataBinding.FieldName = 'ALQIBS01'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Position.BandIndex = 1
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object cxbItensFornecALQ_IS: TcxGridDBBandedColumn
            Caption = '% IS'
            DataBinding.FieldName = 'ALQ_IS01'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Position.BandIndex = 1
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
          object cxbItensFornecVALTOT: TcxGridDBBandedColumn
            AlternateCaption = 'Valor Total'
            Caption = 'Valor Total'
            DataBinding.FieldName = 'VALTOT01'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 76
            Position.BandIndex = 1
            Position.ColIndex = 9
            Position.RowIndex = 0
          end
          object cxbItensFornecDTAULT: TcxGridDBBandedColumn
            Caption = 'Data '#218'lt.Com.'
            DataBinding.FieldName = 'DTAULT'
            OnCustomDrawCell = cxbItensFornecDTAULTCustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 71
            Position.BandIndex = 1
            Position.ColIndex = 10
            Position.RowIndex = 0
          end
          object cxbItensFornecFORULT: TcxGridDBBandedColumn
            Caption = 'Fornecedor da '#218'ltima Compra'
            DataBinding.FieldName = 'FORULT'
            OnCustomDrawCell = cxbItensFornecDTAULTCustomDrawCell
            Options.Editing = False
            Width = 158
            Position.BandIndex = 1
            Position.ColIndex = 11
            Position.RowIndex = 0
          end
          object cxbItensFornecPREULT: TcxGridDBBandedColumn
            Caption = 'Unit.'#218'lt.Com.'
            DataBinding.FieldName = 'PREULT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbItensFornecDTAULTCustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 66
            Position.BandIndex = 1
            Position.ColIndex = 12
            Position.RowIndex = 0
          end
          object cxbItensFornecGERPED: TcxGridDBBandedColumn
            Caption = 'Gerou Pedido'
            DataBinding.FieldName = 'GERPED'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            HeaderAlignmentHorz = taCenter
            Width = 75
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbItensFornecIMPULT: TcxGridDBBandedColumn
            Caption = #218'lt.Com.+Imp'
            DataBinding.FieldName = 'IMPULT'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbItensFornecDTAULTCustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 66
            Position.BandIndex = 1
            Position.ColIndex = 13
            Position.RowIndex = 0
          end
          object cxbItensFornecITESIM: TcxGridDBBandedColumn
            DataBinding.FieldName = 'ITESIM'
            Visible = False
            OnCustomDrawCell = cxbItensFornecCODITECustomDrawCell
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxbItensFornecORDITE: TcxGridDBBandedColumn
            DataBinding.FieldName = 'ORDITE'
            Visible = False
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
        end
        object cxgItensFornecLevel1: TcxGridLevel
          GridView = cxbItensFornec
        end
      end
      object pnlTotFor: TPanel
        Left = 0
        Top = 506
        Width = 1342
        Height = 64
        Align = alBottom
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 2
        object Label19: TLabel
          Left = 10
          Top = 36
          Width = 92
          Height = 14
          Caption = 'Total Valor Unit'#225'rio:'
        end
        object Label20: TLabel
          Left = 226
          Top = 36
          Width = 38
          Height = 14
          Caption = 'Total IPI:'
        end
        object Label21: TLabel
          Left = 386
          Top = 36
          Width = 87
          Height = 14
          Caption = 'Total Substitui'#231#227'o:'
        end
        object Label22: TLabel
          Left = 786
          Top = 36
          Width = 54
          Height = 14
          Caption = 'Total Geral:'
        end
        object Label23: TLabel
          Left = 586
          Top = 36
          Width = 53
          Height = 14
          Caption = 'Total Frete:'
        end
        object edtValTot: TEditFocus
          Left = 842
          Top = 30
          Width = 100
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValSub: TEditFocus
          Left = 475
          Top = 30
          Width = 100
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValIpi: TEditFocus
          Left = 265
          Top = 30
          Width = 100
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValUni: TEditFocus
          Left = 104
          Top = 30
          Width = 100
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValFre: TEditFocus
          Left = 643
          Top = 30
          Width = 100
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 4
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnReplicaDados: TBitBtnLocked
          Left = 643
          Top = 2
          Width = 114
          Height = 22
          Caption = '[ F2 ] Replicar Dados'
          Enabled = False
          TabOrder = 5
          OnClick = btnReplicaDadosClick
        end
        object lblValCbs: TLabel
          Left = 10
          Top = 8
          Width = 50
          Height = 14
          Caption = 'Total CBS:'
        end
        object lblValIbs: TLabel
          Left = 214
          Top = 8
          Width = 50
          Height = 14
          Alignment = taRightJustify
          Caption = 'Total IBS:'
        end
        object lblValIs: TLabel
          Left = 386
          Top = 8
          Width = 50
          Height = 14
          Caption = 'Total IS:'
        end
        object edtValCbs: TEditFocus
          Left = 104
          Top = 2
          Width = 100
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValIbs: TEditFocus
          Left = 265
          Top = 2
          Width = 100
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 7
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtValIs: TEditFocus
          Left = 475
          Top = 2
          Width = 100
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          ReadOnly = True
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tabComparativo: TTabSheet
      Caption = '&4- Comparativo'
      ImageIndex = 3
      object pnlComparativoCtn: TPanel
        Left = 0
        Top = 0
        Width = 1342
        Height = 456
        Align = alClient
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object splAplicacaoTopo: TSplitter
          Left = 0
          Top = 249
          Width = 1342
          Height = 5
          Cursor = crVSplit
          Align = alBottom
          AutoSnap = False
          Beveled = True
          Color = clYellow
          MinSize = 20
          ParentColor = False
          ResizeStyle = rsNone
          ExplicitLeft = 31
          ExplicitTop = 261
          ExplicitWidth = 1352
        end
        object pnlCotainerComp: TPanel
          Left = 0
          Top = 0
          Width = 1342
          Height = 249
          Align = alClient
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Panel5: TPanel
            Left = 1
            Top = 1
            Width = 1340
            Height = 73
            Align = alTop
            BevelOuter = bvNone
            BorderWidth = 5
            ParentBackground = False
            ParentColor = True
            TabOrder = 0
            object lblForUti: TLabel
              Left = 5
              Top = 5
              Width = 1330
              Height = 14
              Align = alTop
              Caption = 'Fornecedores utilizados para compara'#231#227'o de pre'#231'o:'
              Layout = tlCenter
              ExplicitWidth = 253
            end
            object lsvForUti: TCheckListBox
              Tag = 99
              Left = 5
              Top = 19
              Width = 1330
              Height = 49
              OnClickCheck = lsvForUtiClickCheck
              Align = alClient
              Columns = 3
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ItemHeight = 14
              ParentFont = False
              TabOrder = 0
            end
          end
          object Panel1: TPanel
            Left = 1
            Top = 228
            Width = 1340
            Height = 20
            Align = alBottom
            Color = 16770261
            ParentBackground = False
            TabOrder = 1
            object lblOcultarGiro: TLabel
              Left = 184
              Top = 3
              Width = 65
              Height = 14
              Cursor = crHandPoint
              Caption = 'Ocultar Giro'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlue
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold, fsUnderline]
              ParentFont = False
              OnClick = lblOcultarGiroClick
            end
            object btnCfgGri: TBitBtnLocked
              Left = -1
              Top = 0
              Width = 165
              Height = 19
              Caption = 'Confi&gura colunas'
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000010000000A09070663583F36EC573D35EC1911105A000000020000
                00090000000E0000000F00000010000000100000001100000011000000110000
                00130000001A0E0A09745D4C44FEC8A995FFC9A996FF553C34E900000008815A
                4EC0B37E6CFFB37D6AFFB37E6CFFB27D6BFFB27C69FFB17D6AFFBE9081FFD1B6
                ADFF947E77FF6D594FFFD6B6A1FFD4B6A1FFDBC7B9FF584037EC0000000CB581
                6FFFFDFBF9FFFBF5F2FFF9F4F0FFF5EFEBFFF1EBE7FFEEE7E3FFECE4E0FFADA2
                9DFF79645AFFD8BBAAFFD8BBA8FFE6D4C7FF8C766CFE1D15125D0000000CB884
                71FFFDFBFAFFF5EBE4FFEBE1DAFFA29089FF6A534BFF4B332BFF574239FF856F
                64FFDCC1B2FFDCC2B0FFEAD7CCFF978177FF2219166F000000080000000BB886
                75FFFCFAFAFFEAE1DBFF816A61FF937A6FFFBFA99CFFDEC8BAFFC7B0A2FFE0C8
                B8FFDFC7B7FFE9DACFFF9B857BFFA88F87FF00000018000000010000000ABA89
                78FFFAF8F7FFAC9A92FFA08A80FFEEE1D9FFF5EDE7FFF0E4DBFFE9D6C8FFE2CC
                BDFFE2CEBFFFA08A80FFBEB1ABFFD6BBB3FF000000110000000000000009BD8C
                7AFFF8F7F6FF8E7368FFC8B6ADFFB4A098FF8F766AFFB09C93FFD8C8BFFFE5CE
                BFFFD1B9ABFF82675DFFEFE9E5FFC4998AFF0000000F0000000000000009C08F
                7FFFF8F7F6FF8C7165FFB7A299FFBFAFA7FFEEE6E1FFBBAAA1FFAF9B92FFE6D1
                C3FFE6D2C7FF7E6459FFF2EDE9FFBB8A77FF0000000E0000000000000008C394
                84FFFAFAF9FF9D867BFFC7B8B0FFF6F0EAFFF8F1ECFFEAE1DCFF71574DFFE7D4
                C6FFD2C0B8FF8C7369FFF5F0EDFFBC8D7AFF0000000D0000000000000007C597
                87FFFDFDFCFFF8F3EEFFF9F3EFFFFAF4EFFFF7F0ECFFA89791FF937C72FFEEE0
                D8FFB09C92FFB9A8A0FFF9F4F1FFC08F7EFF0000000D0000000000000006C79A
                8CFFFEFEFEFFFAF6F3FFFAF5F3FFF9F4F0FFAB9B93FF8F7A72FFCABAB2FFB6A2
                97FFA38C81FFF4ECE8FFFCF8F6FFC39282FF0000000C0000000000000006CA9E
                8EFFFFFEFEFFFBF7F4FFFBF6F4FFF9F4F2FFAC9589FF987D6FFFA58E85FFC6B6
                AFFFF6EFEAFFF9F4EFFFFDFAF8FFC49687FF0000000B0000000000000005CCA3
                91FFFFFEFEFFFCF8F7FFFCF8F6FFFCF7F5FFFAF5F3FFF8F3F1FFF8F3F1FFFAF4
                F1FFFCF6F2FFFBF6F1FFFDFBF9FFC79A8BFF0000000A0000000000000004CEA4
                95FFFFFFFEFFFFFFFEFFFFFEFEFFFFFEFEFFFEFEFEFFFEFEFEFFFEFEFDFFFEFE
                FDFFFEFDFDFFFEFDFDFFFEFDFCFFC99E8EFF0000000900000000000000029A7B
                6FC0CFA696FFCFA696FFCEA695FFCEA595FFCEA595FFCFA494FFCDA494FFCEA3
                93FFCCA293FFCDA292FFCBA292FF97776BC20000000600000000}
              TabOrder = 0
              OnClick = btnCfgGriClick
            end
          end
          object cxvComparativo: TcxGrid
            Left = 1
            Top = 74
            Width = 1340
            Height = 154
            Align = alClient
            TabOrder = 2
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxbComparativo: TcxGridDBBandedTableView
              OnKeyDown = cxbComparativoKeyDown
              OnKeyPress = cxbComparativoKeyPress
              Navigator.Buttons.CustomButtons = <>
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <
                item
                  Kind = skSum
                  FieldName = 'TOTESC01'
                  Column = cxbComparativoVALTOT01
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC02'
                  Column = cxbComparativoVALTOT02
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC03'
                  Column = cxbComparativoVALTOT03
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC04'
                  Column = cxbComparativoVALTOT04
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC05'
                  Column = cxbComparativoVALTOT05
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC06'
                  Column = cxbComparativoVALTOT06
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC07'
                  Column = cxbComparativoVALTOT07
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC08'
                  Column = cxbComparativoVALTOT08
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC09'
                  Column = cxbComparativoVALTOT09
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC10'
                  Column = cxbComparativoVALTOT10
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC11'
                  Column = cxbComparativoVALTOT11
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC12'
                  Column = cxbComparativoVALTOT12
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC13'
                  Column = cxbComparativoVALTOT13
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC14'
                  Column = cxbComparativoVALTOT14
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC15'
                  Column = cxbComparativoVALTOT15
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC16'
                  Column = cxbComparativoVALTOT16
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC17'
                  Column = cxbComparativoVALTOT17
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC18'
                  Column = cxbComparativoVALTOT18
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC19'
                  Column = cxbComparativoVALTOT19
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC20'
                  Column = cxbComparativoVALTOT20
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC21'
                  Column = cxbComparativoVALTOT21
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC22'
                  Column = cxbComparativoVALTOT22
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC23'
                  Column = cxbComparativoVALTOT23
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC24'
                  Column = cxbComparativoVALTOT24
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC25'
                  Column = cxbComparativoVALTOT25
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC26'
                  Column = cxbComparativoVALTOT26
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC27'
                  Column = cxbComparativoVALTOT27
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC28'
                  Column = cxbComparativoVALTOT28
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC29'
                  Column = cxbComparativoVALTOT29
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC30'
                  Column = cxbComparativoVALTOT30
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC31'
                  Column = cxbComparativoVALTOT31
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC32'
                  Column = cxbComparativoVALTOT32
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC33'
                  Column = cxbComparativoVALTOT33
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC34'
                  Column = cxbComparativoVALTOT34
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC35'
                  Column = cxbComparativoVALTOT35
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC36'
                  Column = cxbComparativoVALTOT36
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC37'
                  Column = cxbComparativoVALTOT37
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC38'
                  Column = cxbComparativoVALTOT38
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC39'
                  Column = cxbComparativoVALTOT39
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC40'
                  Column = cxbComparativoVALTOT40
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC41'
                  Column = cxbComparativoVALTOT41
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC42'
                  Column = cxbComparativoVALTOT42
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC43'
                  Column = cxbComparativoVALTOT43
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC44'
                  Column = cxbComparativoVALTOT44
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC45'
                  Column = cxbComparativoVALTOT45
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC46'
                  Column = cxbComparativoVALTOT46
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC47'
                  Column = cxbComparativoVALTOT47
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC48'
                  Column = cxbComparativoVALTOT48
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC49'
                  Column = cxbComparativoVALTOT49
                end
                item
                  Kind = skSum
                  FieldName = 'TOTESC50'
                  Column = cxbComparativoVALTOT50
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT01'
                  Column = cxbComparativoVALTOT01
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT02'
                  Column = cxbComparativoVALTOT02
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT03'
                  Column = cxbComparativoVALTOT03
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT04'
                  Column = cxbComparativoVALTOT04
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT05'
                  Column = cxbComparativoVALTOT05
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT06'
                  Column = cxbComparativoVALTOT06
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT07'
                  Column = cxbComparativoVALTOT07
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT08'
                  Column = cxbComparativoVALTOT08
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT09'
                  Column = cxbComparativoVALTOT09
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT10'
                  Column = cxbComparativoVALTOT10
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT11'
                  Column = cxbComparativoVALTOT11
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT12'
                  Column = cxbComparativoVALTOT12
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT13'
                  Column = cxbComparativoVALTOT13
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT14'
                  Column = cxbComparativoVALTOT14
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT15'
                  Column = cxbComparativoVALTOT15
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT16'
                  Column = cxbComparativoVALTOT16
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT17'
                  Column = cxbComparativoVALTOT17
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT18'
                  Column = cxbComparativoVALTOT18
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT19'
                  Column = cxbComparativoVALTOT19
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT20'
                  Column = cxbComparativoVALTOT20
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT21'
                  Column = cxbComparativoVALTOT21
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT22'
                  Column = cxbComparativoVALTOT22
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT23'
                  Column = cxbComparativoVALTOT23
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT24'
                  Column = cxbComparativoVALTOT24
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT25'
                  Column = cxbComparativoVALTOT25
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT26'
                  Column = cxbComparativoVALTOT26
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT27'
                  Column = cxbComparativoVALTOT27
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT28'
                  Column = cxbComparativoVALTOT28
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT29'
                  Column = cxbComparativoVALTOT29
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT30'
                  Column = cxbComparativoVALTOT30
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT31'
                  Column = cxbComparativoVALTOT31
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT32'
                  Column = cxbComparativoVALTOT32
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT33'
                  Column = cxbComparativoVALTOT33
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT34'
                  Column = cxbComparativoVALTOT34
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT35'
                  Column = cxbComparativoVALTOT35
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT36'
                  Column = cxbComparativoVALTOT36
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT37'
                  Column = cxbComparativoVALTOT37
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT38'
                  Column = cxbComparativoVALTOT38
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT39'
                  Column = cxbComparativoVALTOT39
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT40'
                  Column = cxbComparativoVALTOT40
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT41'
                  Column = cxbComparativoVALTOT41
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT42'
                  Column = cxbComparativoVALTOT42
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT43'
                  Column = cxbComparativoVALTOT43
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT44'
                  Column = cxbComparativoVALTOT44
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT45'
                  Column = cxbComparativoVALTOT45
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT46'
                  Column = cxbComparativoVALTOT46
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT47'
                  Column = cxbComparativoVALTOT47
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT48'
                  Column = cxbComparativoVALTOT48
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT49'
                  Column = cxbComparativoVALTOT49
                end
                item
                  Kind = skSum
                  FieldName = 'VALTOT50'
                  Column = cxbComparativoVALTOT50
                end>
              DataController.Summary.SummaryGroups = <>
              DataController.OnCompare = cxbComparativoDataControllerCompare
              DataController.OnFilterRecord = cxbComparativoDataControllerFilterRecord
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.Visible = True
              FilterRow.ApplyChanges = fracImmediately
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsSelection.HideFocusRectOnExit = False
              OptionsView.NoDataToDisplayInfoText = ' '
              OptionsView.Footer = True
              OptionsView.FooterMultiSummaries = True
              OptionsView.GroupByBox = False
              Styles.ContentEven = cxStyle3
              Styles.Footer = cxStyle1
              Bands = <
                item
                  Caption = 'Dados do Produto'
                  FixedKind = fkLeft
                end
                item
                  Caption = 'Pre'#231'os do Fornecedor'
                  Width = 4000
                end
                item
                  Caption = 'Diferen'#231'a de Pre'#231'o'
                  FixedKind = fkRight
                end>
              object cxbComparativoCODITE: TcxGridDBBandedColumn
                Caption = 'C'#243'd.Item'
                DataBinding.FieldName = 'CODITE'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                SortIndex = 0
                SortOrder = soAscending
                Width = 76
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxbComparativoCODFAB: TcxGridDBBandedColumn
                Caption = 'C'#243'digo F'#225'brica'
                DataBinding.FieldName = 'CODFAB'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                Options.Editing = False
                Width = 110
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxbComparativoDESITE: TcxGridDBBandedColumn
                Caption = 'Descri'#231#227'o do Item'
                DataBinding.FieldName = 'DESITE'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                Options.Editing = False
                Width = 229
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxbComparativoREFERE: TcxGridDBBandedColumn
                Caption = 'Refer'#234'ncia'
                DataBinding.FieldName = 'REFERE'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 81
                Position.BandIndex = 1
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object cxbComparativoDESMAR: TcxGridDBBandedColumn
                Caption = 'Marca'
                DataBinding.FieldName = 'DESMAR'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                Options.Editing = False
                Width = 79
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxbComparativoQTDITE: TcxGridDBBandedColumn
                Caption = 'Quantidade'
                DataBinding.FieldName = 'QTDITE'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taRightJustify
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object cxbComparativoDTAULT: TcxGridDBBandedColumn
                Caption = 'Data '#218'lt.Com.'
                DataBinding.FieldName = 'DTAULT'
                OnCustomDrawCell = cxbItensFornecDTAULTCustomDrawCell
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 75
                Position.BandIndex = 1
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object cxbComparativoFORULT: TcxGridDBBandedColumn
                Caption = 'Fornecedor da '#218'ltima Compra'
                DataBinding.FieldName = 'FORULT'
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.Alignment.Horz = taLeftJustify
                OnCustomDrawCell = cxbItensFornecDTAULTCustomDrawCell
                Options.Editing = False
                Width = 151
                Position.BandIndex = 1
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object cxbComparativoPREULT: TcxGridDBBandedColumn
                Caption = 'Unit.'#218'lt.Com.'
                DataBinding.FieldName = 'PREULT'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbItensFornecDTAULTCustomDrawCell
                HeaderAlignmentHorz = taRightJustify
                Options.Editing = False
                Width = 71
                Position.BandIndex = 1
                Position.ColIndex = 58
                Position.RowIndex = 0
              end
              object cxbComparativoIMPULT: TcxGridDBBandedColumn
                Caption = #218'lt.Com.+Imp'
                DataBinding.FieldName = 'IMPULT'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbItensFornecDTAULTCustomDrawCell
                HeaderAlignmentHorz = taRightJustify
                Options.Editing = False
                Width = 74
                Position.BandIndex = 1
                Position.ColIndex = 57
                Position.RowIndex = 0
              end
              object cxbComparativoCODSIM: TcxGridDBBandedColumn
                Caption = 'C'#243'd. Similar'
                DataBinding.FieldName = 'CODSIM'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 74
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object cxbComparativoSIGUNI: TcxGridDBBandedColumn
                Caption = 'Unid.'
                DataBinding.FieldName = 'SIGUNI'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                FooterAlignmentHorz = taCenter
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 20
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object cxbComparativoPRECUS: TcxGridDBBandedColumn
                Caption = 'Pre'#231'o Custo'
                DataBinding.FieldName = 'PRECUS'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 70
                Options.Editing = False
                Width = 70
                Position.BandIndex = 2
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
              object cxbComparativoDIFCUS: TcxGridDBBandedColumn
                Caption = 'Dif.Custo%'
                DataBinding.FieldName = 'DIFCUS'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 65
                Options.Editing = False
                Width = 65
                Position.BandIndex = 2
                Position.ColIndex = 7
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT01: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT01'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 99
                Position.BandIndex = 1
                Position.ColIndex = 7
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT02: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT02'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 8
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT03: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT03'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 9
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT04: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT04'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 10
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT05: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT05'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 101
                Position.BandIndex = 1
                Position.ColIndex = 11
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT06: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT06'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 99
                Position.BandIndex = 1
                Position.ColIndex = 12
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT07: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT07'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 13
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT08: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT08'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 14
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT09: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT09'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 15
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT10: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT10'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 16
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT11: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT11'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 101
                Position.BandIndex = 1
                Position.ColIndex = 17
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT12: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT12'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 99
                Position.BandIndex = 1
                Position.ColIndex = 18
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT13: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT13'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 19
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT14: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT14'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 20
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT15: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT15'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 21
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT16: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT16'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 22
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT17: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT17'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 23
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT18: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT18'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 24
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT19: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT19'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 25
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT20: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT20'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 26
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT21: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT21'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 27
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT22: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT22'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 99
                Position.BandIndex = 1
                Position.ColIndex = 28
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT23: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT23'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 101
                Position.BandIndex = 1
                Position.ColIndex = 29
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT24: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT24'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 30
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT25: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT25'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 31
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT26: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT26'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 32
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT27: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT27'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 99
                Position.BandIndex = 1
                Position.ColIndex = 33
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT28: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT28'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 34
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT29: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT29'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 101
                Position.BandIndex = 1
                Position.ColIndex = 35
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT30: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT30'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                Position.BandIndex = 1
                Position.ColIndex = 36
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT31: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT31'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 62
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT32: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT32'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 37
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT33: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT33'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 38
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT34: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT34'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 59
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT35: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT35'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 40
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT36: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT36'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 41
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT37: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT37'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 42
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT38: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT38'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 43
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT39: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT39'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 44
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT40: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT40'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 45
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT41: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT41'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 46
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT42: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT42'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 47
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT43: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT43'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 48
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT44: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT44'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 49
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT45: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT45'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 50
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT46: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT46'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 51
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT47: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT47'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 52
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT48: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT48'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 53
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT49: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT49'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 54
                Position.RowIndex = 0
              end
              object cxbComparativoVALTOT50: TcxGridDBBandedColumn
                DataBinding.FieldName = 'UNITOT50'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoVALTOT01CustomDrawCell
                Options.Editing = False
                Width = 100
                OnHeaderClick = cxbComparativoCODITEHeaderClick
                Position.BandIndex = 1
                Position.ColIndex = 55
                Position.RowIndex = 0
              end
              object cxbComparativoFORMEN: TcxGridDBBandedColumn
                DataBinding.FieldName = 'FORMEN'
                Visible = False
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                Position.BandIndex = 1
                Position.ColIndex = 61
                Position.RowIndex = 0
              end
              object cxbComparativoFORESC: TcxGridDBBandedColumn
                DataBinding.FieldName = 'FORESC'
                Visible = False
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                Position.BandIndex = 1
                Position.ColIndex = 60
                Position.RowIndex = 0
              end
              object cxbComparativoTOTESC: TcxGridDBBandedColumn
                DataBinding.FieldName = 'TOTESC01'
                Visible = False
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                Position.BandIndex = 1
                Position.ColIndex = 39
                Position.RowIndex = 0
              end
              object cxbComparativoVLRUNT: TcxGridDBBandedColumn
                Caption = 'Valor Unit'#225'rio'
                DataBinding.FieldName = 'VLRUNT'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                HeaderAlignmentHorz = taRightJustify
                Options.Editing = False
                Width = 108
                Position.BandIndex = 1
                Position.ColIndex = 56
                Position.RowIndex = 0
              end
              object cxbComparativoMARPED: TcxGridDBBandedColumn
                Caption = 'Gerar Pedido'
                DataBinding.FieldName = 'MARPED'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                Properties.OnChange = cxbComparativoMARPEDPropertiesChange
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                Width = 70
                Position.BandIndex = 0
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object cxbComparativoCUSREA: TcxGridDBBandedColumn
                Caption = 'Pr. Custo Real'
                DataBinding.FieldName = 'CUSREA'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 75
                Options.Editing = False
                Width = 75
                Position.BandIndex = 2
                Position.ColIndex = 8
                Position.RowIndex = 0
              end
              object cxbComparativoDIFREA: TcxGridDBBandedColumn
                Caption = 'Dif.Custo Real%'
                DataBinding.FieldName = 'DIFREA'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = '0.00;-0.00'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 85
                Options.Editing = False
                Width = 85
                Position.BandIndex = 2
                Position.ColIndex = 9
                Position.RowIndex = 0
              end
              object cxbComparativoColumn1: TcxGridDBBandedColumn
                Caption = 'Pr.Com.Liq'
                DataBinding.FieldName = 'COMLIQ'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 60
                Options.Editing = False
                Width = 60
                Position.BandIndex = 2
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxbComparativoColumn2: TcxGridDBBandedColumn
                Caption = '% IPI Ent'
                DataBinding.FieldName = 'IPIENT'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 52
                Options.Editing = False
                Width = 52
                Position.BandIndex = 2
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object cxbComparativoColumn3: TcxGridDBBandedColumn
                Caption = '% ST Ent'
                DataBinding.FieldName = 'SUBSTI'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 52
                Options.Editing = False
                Width = 52
                Position.BandIndex = 2
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object cxbComparativoColumn4: TcxGridDBBandedColumn
                Caption = 'Pr.Com.Liq+Imp'
                DataBinding.FieldName = 'PREIMP'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 85
                Options.Editing = False
                Width = 85
                Position.BandIndex = 2
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object cxbComparativoColumn5: TcxGridDBBandedColumn
                Caption = 'Dif.Com.Liq+Imp %'
                DataBinding.FieldName = 'DIFPREIMP'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00;-,0.00'
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                HeaderAlignmentHorz = taCenter
                MinWidth = 100
                Options.Editing = False
                Width = 100
                Position.BandIndex = 2
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object cxbComparativoITESIM: TcxGridDBBandedColumn
                DataBinding.FieldName = 'ITESIM'
                Visible = False
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                VisibleForCustomization = False
                Position.BandIndex = 0
                Position.ColIndex = 4
                Position.RowIndex = 0
              end
              object cxbComparativoORDITE: TcxGridDBBandedColumn
                DataBinding.FieldName = 'ORDITE'
                Visible = False
                OnCustomDrawCell = cxbComparativoCODITECustomDrawCell
                VisibleForCustomization = False
                Position.BandIndex = 0
                Position.ColIndex = 5
                Position.RowIndex = 0
              end
              object cxbComparativoDIFCOL: TcxGridDBBandedColumn
                Caption = 'Dif. Com. Liq %'
                DataBinding.FieldName = 'DIFCOL'
                PropertiesClassName = 'TcxCurrencyEditProperties'
                Properties.DisplayFormat = ',0.00 %;-,0.00%'
                Properties.ReadOnly = True
                HeaderAlignmentHorz = taCenter
                Options.Editing = False
                Width = 100
                Position.BandIndex = 2
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxbComparativoGERPED: TcxGridDBBandedColumn
                Caption = 'Gerou Pedido'
                DataBinding.FieldName = 'GERPED'
                Visible = False
                Position.BandIndex = 0
                Position.ColIndex = 6
                Position.RowIndex = 0
              end
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxbComparativo
            end
          end
        end
        object pnlContainerGiroComparativo: TPanel
          Left = 0
          Top = 254
          Width = 1342
          Height = 202
          Align = alBottom
          ParentColor = True
          TabOrder = 1
          object splAplicacaoRodape: TSplitter
            Left = 1
            Top = 59
            Width = 1340
            Height = 5
            Cursor = crVSplit
            Align = alTop
            AutoSnap = False
            Beveled = True
            Color = clYellow
            MinSize = 20
            ParentColor = False
            ResizeStyle = rsNone
            ExplicitTop = 61
            ExplicitWidth = 1350
          end
          object pnlContainerAplicacao: TPanel
            Left = 1
            Top = 1
            Width = 1340
            Height = 58
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object pnlTituloAplicacao: TPanel
              Left = 0
              Top = 0
              Width = 1340
              Height = 15
              Align = alTop
              BevelOuter = bvNone
              Caption = 'Aplica'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 0
            end
            object dbeAplicaComparativo: TDBMemoFocus
              Left = 0
              Top = 15
              Width = 1340
              Height = 43
              Align = alClient
              DataField = 'APLICA'
              ReadOnly = True
              TabOrder = 1
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              StringQuebra = '<<csq>>'
            end
          end
          object pnlGiroComparativo: TPanel
            Left = 1
            Top = 64
            Width = 1340
            Height = 137
            Align = alClient
            BevelOuter = bvNone
            Caption = 'o pe'
            Color = 16770261
            ParentBackground = False
            TabOrder = 1
            Visible = False
          end
        end
      end
      object pnlBotoesComparativo: TPanel
        Left = 0
        Top = 456
        Width = 1342
        Height = 114
        Align = alBottom
        BevelOuter = bvNone
        Constraints.MinHeight = 114
        ParentBackground = False
        ParentColor = True
        TabOrder = 1
        OnCanResize = pnlBotoesComparativoCanResize
        object Label10: TLabel
          Left = 31
          Top = 25
          Width = 113
          Height = 14
          Caption = 'Total geral selecionado:'
        end
        object Label11: TLabel
          Left = 0
          Top = 3
          Width = 268
          Height = 14
          Caption = ' *O valor total exibido j'#225' foi calculado com IPI e ST'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Shape1: TShape
          Left = 792
          Top = 54
          Width = 15
          Height = 15
          Brush.Color = clYellow
        end
        object Label12: TLabel
          Left = 811
          Top = 56
          Width = 150
          Height = 14
          Caption = 'Pre'#231'o escolhido e menor pre'#231'o'
        end
        object Shape2: TShape
          Left = 792
          Top = 73
          Width = 15
          Height = 15
          Brush.Color = 47545
        end
        object Label13: TLabel
          Left = 812
          Top = 74
          Width = 175
          Height = 14
          Caption = 'Pre'#231'o escolhido, mas n'#227'o '#233' o menor'
        end
        object Shape5: TShape
          Left = 792
          Top = 91
          Width = 15
          Height = 15
          Brush.Color = clGreen
        end
        object Label16: TLabel
          Left = 812
          Top = 92
          Width = 172
          Height = 14
          Caption = 'Menor pre'#231'o, mas n'#227'o foi escolhido'
        end
        object Label17: TLabel
          Left = 355
          Top = 3
          Width = 427
          Height = 14
          Caption = 
            'Primeira linha de total = TOTAL DOS ITENS SELECIONADOS PARA O FO' +
            'RNECEDOR'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label18: TLabel
          Left = 355
          Top = 16
          Width = 354
          Height = 14
          Caption = 'Segunda linha de total = TOTAL DE TODOS OS ITENS DA COTA'#199#195'O '
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edtTotGer: TEditFocus
          Left = 148
          Top = 19
          Width = 118
          Height = 22
          TabStop = False
          Alignment = taRightJustify
          Color = 16768952
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnMarPre: TBitBtnLocked
          Left = 5
          Top = 47
          Width = 234
          Height = 22
          Caption = '[SPACE] Marca/Demarca como escolhido'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
            555555555555555555555555555555555555555555FF55555555555559055555
            55555555577FF5555555555599905555555555557777F5555555555599905555
            555555557777FF5555555559999905555555555777777F555555559999990555
            5555557777777FF5555557990599905555555777757777F55555790555599055
            55557775555777FF5555555555599905555555555557777F5555555555559905
            555555555555777FF5555555555559905555555555555777FF55555555555579
            05555555555555777FF5555555555557905555555555555777FF555555555555
            5990555555555555577755555555555555555555555555555555}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = btnMarPreClick
        end
        object btnSelMen: TBitBtnLocked
          Left = 571
          Top = 47
          Width = 194
          Height = 22
          Caption = 'Selecionar &Menores Pre'#231'os'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A87D78B78183B78183B78183B78183B78183B78183B78183B78183B78183B781
            83B78183B78183FF00FFFF00FFFF00FFAB7F79F6E6CAF6E3C5F5E1C0F5DFBBF4
            DDB7F3DBB3F3D9AFF2D7ABF1D6A8F1D3A5F1D3A2B3897BFF00FFFF00FFFF00FF
            AE827AF7E8CE006600F6E4C6F6E1C19933009933009933009933009933009933
            00F2D4A5B3897BFF00FFFF00FFFF00FFB2857CF9EBD5F8E8D0F7E6CBF7E4C6F5
            E1C2F5E0BDF4DDB9F3DBB5F3DAB1F2D7ADF2D5A9B3897BFF00FFFF00FF006600
            0066000066000066000066000066000066000066000066000066000066000066
            00006600006600006600FF00FF006600BB8E80FAF0DF006600F9ECD6F9E9D199
            3300993300993300993300993300993300F4DAB2B3897B006600FF00FF006600
            0066000066000066000066000066000066000066000066000066000066000066
            00006600006600006600FF00FFFF00FFC69784FCF5E9FBF2E5FAF0E1F9EEDCF9
            ECD7F9EAD3F8E8CEF7E5C9F6E4C5F5E1C1F4DFBCB3897BFF00FFFF00FFFF00FF
            CB9C86BDB9B2004C00BCB6ACFAF1E19933009933009933009933009933009933
            00F6E2C1B3897BFF00FFFF00FFFF00FF006600006600006600BCB8B0FCF4E6FB
            F2E2FAF0DEF9ECD9F8EAD5F8E9D0F7E7CCF7E4C6B3897BFF00FFFF00FFFF00FF
            0066001BAF2E006600BEB9B3BDB8B0BDB6AEFAF2E3FAF0DEF9EDDAF9EBD6F8E9
            D1F7E6CCB3897BFF00FF00660000660000660029BE4500660000660000660073
            2600993300993300993300993300993300F8E9D2B3897BFF00FF0066004AE37B
            43DB6F39D05F2EC44D24B83C006600BEBAB4FDF6ECFCF4E9FBF3E5FBF0E0FAEE
            DCF9EBD7B3897BFF00FF00660000660000660047DF75006600006600006600FD
            FAF4FDF9F1FCF7EDFBF5EAFBF3E5FAF1E2FAEEDCB3897BFF00FFFF00FFFF00FF
            0066004DE67F006600A37B61DAA482DAA482DAA482DAA482DAA482DAA482DAA4
            82DAA482DAA482FF00FFFF00FFFF00FF006600006600006600FF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 2
          OnClick = btnSelMenClick
        end
        object btnExpExcel: TBitBtnLocked
          Left = 446
          Top = 91
          Width = 159
          Height = 22
          Caption = '&Exportar (Excel)'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FF0084000084000084000084000084000084000084000084
            00008400008400008400AA7F7AB88384B88384B88384B88384008400FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008400AD827BFCEBCE
            F7DFBFF4DAB3F3D6AB008400FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF008400B1857CFDEDD5F5DFC5F4DBBBF2D7B2008400FFFFFF91
            CA91008400309B30FBFDFB84C48400840068B668FFFFFF008400B6897EFEF2DE
            F7E5CEF5E0C5F4DCBC008400FFFFFFFFFFFFC4E3C40486041C911C00840084C4
            84FFFFFFFFFFFF008400BA8D80FFF7E8F8E8D6F6E4CDF5E0C4008400FFFFFFFF
            FFFFFFFFFF69B769008400178F17FBFDFBFFFFFFFFFFFF008400BF9183FFFCF2
            F9EDDFF7E8D6F6E4CD008400FFFFFFFFFFFF7ABF7A00840065B5650486043AA0
            3AF2F9F2FFFFFF008400C49685FFFFFCFAF1E8F9ECDEF8E8D5008400FFFFFF61
            B3610084007BBF7BFFFFFFCAE5CA0385033AA03AFFFFFF008400C99B87FFFFFF
            FDF7F2FBF1E8FAEEDF008400FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFF008400CD9E8AFFFFFFFFFCFBFEF7F1FBF2E7008400FFFFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008400D1A38BFFFFFF
            FFFFFFFFFDFBFDF7F10084000084000084000084000084000084000084000084
            00008400008400008400D6A78DFFFFFFFFFFFFFFFFFFFFFDFBFDF7F1FBF1E6FA
            EDDEFDF0DDEADDCAC7BFB0B88384FF00FFFF00FFFF00FFFF00FFD9AA8FFFFFFF
            FFFFFFFFFFFFFFFFFFFEFDFBFDF8F0FBF3E7B88384B88384B88384B88384FF00
            FFFF00FFFF00FFFF00FFDDAC91FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF7
            F0ECB88384E9B676F3AE52CA8A6AFF00FFFF00FFFF00FFFF00FFDFAF92FFFFFF
            FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFAFEB88384EBB87AD09877FF00FFFF00
            FFFF00FFFF00FFFF00FFDBA685DBA685DBA685DBA685DBA685DBA685DBA685DB
            A685B88384CA9784FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 4
          OnClick = btnExpExcelClick
        end
        object btnSimilaresComparativo: TBitBtnLocked
          Left = 605
          Top = 91
          Width = 160
          Height = 22
          Caption = '[ F11 ] Similares'
          TabOrder = 5
          Visible = False
          OnClick = btnSimilaresComparativoClick
        end
        object btnAlteraValor: TBitBtnLocked
          Left = 5
          Top = 69
          Width = 234
          Height = 22
          Caption = '[ENTER] Altera valor da cota'#231#227'o'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
            69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
            CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
            A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
            7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
            820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
            A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
            81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
            860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
            A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
            93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
            C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
            BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
            A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
            D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
            D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
            B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
            9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
            DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
            55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
            FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
            E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
            6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
            926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 3
          OnClick = btnAlteraValorClick
        end
        object rdgTotCot: TRadioGroup
          Left = 792
          Top = 1
          Width = 203
          Height = 50
          Caption = 'Totais dos itens selecionados'
          Color = 16770261
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ItemIndex = 1
          Items.Strings = (
            'Selecionados com F2'
            'Geral')
          ParentBackground = False
          ParentColor = False
          ParentFont = False
          TabOrder = 6
          OnClick = rdgTotCotClick
        end
        object btnGerPed: TBitBtnLocked
          Left = 239
          Top = 47
          Width = 332
          Height = 22
          Caption = 'G&erar Pedidos de Compra para todos os itens da cota'#231#227'o'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555000000
            000055555F77777777775555000FFFFFFFF0555F777F5FFFF55755000F0F0000
            FFF05F777F7F77775557000F0F0FFFFFFFF0777F7F7F5FFFFFF70F0F0F0F0000
            00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFFFFF70F0F0F0F0000
            00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFF55570F0F0F0F000F
            FFF07F7F7F7F77755FF70F0F0F0FFFFF00007F7F7F7F5FF577770F0F0F0F00FF
            0F057F7F7F7F77557F750F0F0F0FFFFF00557F7F7F7FFFFF77550F0F0F000000
            05557F7F7F77777775550F0F0000000555557F7F7777777555550F0000000555
            55557F7777777555555500000005555555557777777555555555}
          NumGlyphs = 2
          TabOrder = 7
          OnClick = btnGerPedClick
        end
        object btnGerPedSel: TBitBtnLocked
          Left = 239
          Top = 69
          Width = 332
          Height = 22
          Caption = 'Gerar &Pedidos de Compra para os itens selecionados com [F2]'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000120B0000120B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555000000
            000055555F77777777775555000FFFFFFFF0555F777F5FFFF55755000F0F0000
            FFF05F777F7F77775557000F0F0FFFFFFFF0777F7F7F5FFFFFF70F0F0F0F0000
            00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFFFFF70F0F0F0F0000
            00F07F7F7F7F777777570F0F0F0FFFFFFFF07F7F7F7F5FFF55570F0F0F0F000F
            FFF07F7F7F7F77755FF70F0F0F0FFFFF00007F7F7F7F5FF577770F0F0F0F00FF
            0F057F7F7F7F77557F750F0F0F0FFFFF00557F7F7F7FFFFF77550F0F0F000000
            05557F7F7F77777775550F0F0000000555557F7F7777777555550F0000000555
            55557F7777777555555500000005555555557777777555555555}
          NumGlyphs = 2
          TabOrder = 8
          OnClick = btnGerPedSelClick
        end
        object btnSelPedTodos: TBitBtnLocked
          Left = 5
          Top = 91
          Width = 234
          Height = 22
          Caption = '[Alt+ F2] Marca/Des. todos para gera'#231#227'o ped.'
          TabOrder = 9
          OnClick = btnSelPedTodosClick
        end
        object btnSelPed: TBitBtnLocked
          Left = 239
          Top = 91
          Width = 205
          Height = 22
          Caption = '[ F2 ] Seleciona para gera'#231#227'o do pedido'
          TabOrder = 10
          OnClick = btnSelPedClick
        end
        object btnDocSalRes: TBitBtnLocked
          Left = 571
          Top = 69
          Width = 194
          Height = 22
          Hint = 'Visualizar o documentos que reservam este item'
          Caption = '[Alt+F11] Doc. de Sal. Reservado'
          TabOrder = 11
          OnClick = btnDocSalResClick
        end
      end
    end
    object tabAtualizaPreco: TTabSheet
      Caption = '&5-Atualiza'#231#227'o de Pre'#231'os'
      ImageIndex = 4
      OnHide = tabAtualizaPrecoHide
      OnShow = tabAtualizaPrecoShow
      object pnlComparativo: TPanel
        Left = 0
        Top = 435
        Width = 1342
        Height = 135
        Align = alBottom
        BevelOuter = bvNone
        DockSite = True
        ParentBackground = False
        ParentColor = True
        TabOrder = 0
        object shp6: TShape
          Left = 340
          Top = 85
          Width = 14
          Height = 14
          Brush.Color = clGreen
        end
        object lbl7: TLabel
          Left = 358
          Top = 85
          Width = 234
          Height = 14
          Caption = 'Marcados para atualizar o Cadastro de Produtos'
          Font.Charset = ANSI_CHARSET
          Font.Color = clGreen
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Shape3: TShape
          Left = 340
          Top = 101
          Width = 14
          Height = 14
          Brush.Color = clRed
        end
        object Label14: TLabel
          Left = 358
          Top = 101
          Width = 113
          Height = 14
          Caption = 'Atualiza'#231#227'o de Margem'
          Font.Charset = ANSI_CHARSET
          Font.Color = clRed
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 358
          Top = 117
          Width = 103
          Height = 14
          Caption = 'Atualiza'#231#227'o de Pre'#231'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Shape4: TShape
          Left = 340
          Top = 117
          Width = 14
          Height = 14
          Brush.Color = clBlue
        end
        object GroupBox1: TGroupBox
          Left = 1
          Top = 6
          Width = 433
          Height = 73
          Caption = 'Atualiza'#231#227'o de Pre'#231'os'
          TabOrder = 0
          object btnMarca: TBitBtnLocked
            Left = 5
            Top = 20
            Width = 161
            Height = 22
            Caption = '[ F5 ] Marca/Demarca'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              555555555555555555555555555555555555555555FF55555555555559055555
              55555555577FF5555555555599905555555555557777F5555555555599905555
              555555557777FF5555555559999905555555555777777F555555559999990555
              5555557777777FF5555557990599905555555777757777F55555790555599055
              55557775555777FF5555555555599905555555555557777F5555555555559905
              555555555555777FF5555555555559905555555555555777FF55555555555579
              05555555555555777FF5555555555557905555555555555777FF555555555555
              5990555555555555577755555555555555555555555555555555}
            NumGlyphs = 2
            TabOrder = 0
            OnClick = btnMarcaClick
          end
          object btnMarcaTodos: TBitBtnLocked
            Left = 5
            Top = 41
            Width = 161
            Height = 22
            Caption = '[ F6 ] Marca Todos'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000120B0000120B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
              555555555555555555555555555555555555555555FF55555555555559055555
              55555555577FF5555555555599905555555555557777F5555555555599905555
              555555557777FF5555555559999905555555555777777F555555559999990555
              5555557777777FF5555557990599905555555777757777F55555790555599055
              55557775555777FF5555555555599905555555555557777F5555555555559905
              555555555555777FF5555555555559905555555555555777FF55555555555579
              05555555555555777FF5555555555557905555555555555777FF555555555555
              5990555555555555577755555555555555555555555555555555}
            NumGlyphs = 2
            TabOrder = 1
            OnClick = btnMarcaTodosClick
          end
          object btnDesmarcaTodos: TBitBtnLocked
            Left = 167
            Top = 20
            Width = 258
            Height = 22
            Caption = '[ F7 ] Desmarca Todos'
            Glyph.Data = {
              76010000424D7601000000000000760000002800000020000000100000000100
              04000000000000010000130B0000130B00001000000000000000000000000000
              800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
              FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
              3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
              3333333777333777FF3333993333339993333377FF3333377FF3399993333339
              993337777FF3333377F3393999333333993337F777FF333337FF993399933333
              399377F3777FF333377F993339993333399377F33777FF33377F993333999333
              399377F333777FF3377F993333399933399377F3333777FF377F993333339993
              399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
              99333773FF3333777733339993333339933333773FFFFFF77333333999999999
              3333333777333777333333333999993333333333377777333333}
            NumGlyphs = 2
            TabOrder = 2
            OnClick = btnDesmarcaTodosClick
          end
          object btnAtuPre: TBitBtnLocked
            Left = 167
            Top = 41
            Width = 258
            Height = 22
            Caption = '[ F8 ] Atualiza Cad. Produtos (Pre'#231'os/Margens)'
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
            TabOrder = 3
            OnClick = btnAtuPreClick
          end
        end
        object GroupBox2: TGroupBox
          Left = 432
          Top = 6
          Width = 402
          Height = 73
          Caption = 'Tipo de C'#225'lculo'
          TabOrder = 1
          object btnRecalcPreco: TBitBtnLocked
            Left = 6
            Top = 20
            Width = 389
            Height = 22
            Caption = 
              '[ F9 ]Retorna a margem do cadastro e recalcula Pre'#231'o de Venda pa' +
              'ra todos'
            NumGlyphs = 2
            TabOrder = 0
            OnClick = btnRecalcPrecoClick
          end
          object btnRecalcMargem: TBitBtnLocked
            Left = 6
            Top = 41
            Width = 389
            Height = 22
            Caption = 
              '[ F11 ] Retorna pre'#231'o de venda do cadastro e recalcula Margem pa' +
              'ra todos'
            NumGlyphs = 2
            TabOrder = 1
            OnClick = btnRecalcMargemClick
          end
        end
        object btnDesPreAtu: TBitBtnLocked
          Left = 6
          Top = 85
          Width = 323
          Height = 22
          Caption = '[  F3 ] Desmarca todos os itens como "Pre'#231'o j'#225' atualizado"'
          Glyph.Data = {
            76010000424D7601000000000000760000002800000020000000100000000100
            04000000000000010000130B0000130B00001000000000000000000000000000
            800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
            3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
            3333333777333777FF3333993333339993333377FF3333377FF3399993333339
            993337777FF3333377F3393999333333993337F777FF333337FF993399933333
            399377F3777FF333377F993339993333399377F33777FF33377F993333999333
            399377F333777FF3377F993333399933399377F3333777FF377F993333339993
            399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
            99333773FF3333777733339993333339933333773FFFFFF77333333999999999
            3333333777333777333333333999993333333333377777333333}
          NumGlyphs = 2
          TabOrder = 2
          OnClick = btnDesPreAtuClick
        end
        object btnSimilar: TBitBtnLocked
          Left = 6
          Top = 107
          Width = 323
          Height = 22
          Caption = '[ F12 ] Similares'
          TabOrder = 3
          OnClick = btnSimilaresComparativoClick
        end
      end
      object cxgAtuPrecos: TcxGrid
        Left = 0
        Top = 41
        Width = 1342
        Height = 394
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgItensBandedFixa: TcxGridDBBandedTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          Bands = <
            item
              FixedKind = fkLeft
              Width = 168
            end>
        end
        object cxbAtuPrecos: TcxGridDBBandedTableView
          OnKeyDown = cxbAtuPrecosKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCanFocusRecord = cxbAtuPrecosCanFocusRecord
          OnCustomDrawCell = cxbAtuPrecosCustomDrawCell
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          DataController.OnCompare = cxbAtuPrecosDataControllerCompare
          DataController.OnFilterRecord = cxbAtuPrecosDataControllerFilterRecord
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsView.NoDataToDisplayInfoText = '<Sem pre'#231'os para atualizar>'
          OptionsView.GroupByBox = False
          Styles.ContentEven = cxStyle3
          Bands = <
            item
              Caption = 'Informa'#231#245'es B'#225'sicas do Item'
              FixedKind = fkLeft
              Width = 347
            end
            item
              Caption = 'Informa'#231#245'es  Complementares'
              Width = 295
            end
            item
              Caption = 'Pre'#231'o de Compra'
              Width = 230
            end
            item
              Caption = 'Pre'#231'o de Custo'
              Width = 230
            end
            item
              Caption = 'Tabela 1'
              Width = 400
            end
            item
              Caption = 'Tabela 2'
              Width = 400
            end
            item
              Caption = 'Tabela 3'
              Width = 400
            end
            item
              Caption = 'Tabela 4'
              Width = 400
            end
            item
              Caption = 'Tabela 5'
              Width = 400
            end
            item
              Caption = 'Tabela 6'
              Width = 400
            end
            item
              Caption = 'Tabela 7'
              Width = 400
            end
            item
              Caption = 'Atualizar'
              FixedKind = fkRight
              Width = 240
            end>
          object cxbAtuPrecosCODITE: TcxGridDBBandedColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODITE'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
            Width = 62
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosCODFAB: TcxGridDBBandedColumn
            Caption = 'C'#243'digo de F'#225'brica'
            DataBinding.FieldName = 'CODFAB'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 96
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosDESITE: TcxGridDBBandedColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESITE'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            Options.Editing = False
            Width = 189
            Position.BandIndex = 0
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosLOCFIS: TcxGridDBBandedColumn
            Caption = 'Local. F'#237'sica'
            DataBinding.FieldName = 'LOCFIS'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 93
            Position.BandIndex = 1
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosSIGUNI: TcxGridDBBandedColumn
            Caption = 'Unid.'
            DataBinding.FieldName = 'SIGUNI'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 47
            Position.BandIndex = 1
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosREFERE: TcxGridDBBandedColumn
            Caption = 'Refer'#234'ncia'
            DataBinding.FieldName = 'REFERE'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 83
            Position.BandIndex = 1
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPRECOT: TcxGridDBBandedColumn
            Caption = 'Cota'#231#227'o'
            DataBinding.FieldName = 'PREESC'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Options.Editing = False
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPRECOM: TcxGridDBBandedColumn
            Caption = 'Atual'
            DataBinding.FieldName = 'PRECOM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Options.Editing = False
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVCUS: TcxGridDBBandedColumn
            Caption = 'Novo'
            DataBinding.FieldName = 'NOVCUS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Options.Editing = False
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPRECUS: TcxGridDBBandedColumn
            Caption = 'Atual'
            DataBinding.FieldName = 'PRECUS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Options.Editing = False
            Position.BandIndex = 3
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosMARBR1: TcxGridDBBandedColumn
            Caption = 'Margem Atual'
            DataBinding.FieldName = 'MARBR1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 4
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVVE1: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Novo'
            DataBinding.FieldName = 'NOVVE1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVVE1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVVE1CustomDrawCell
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 4
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbAtuPrecosMARBR2: TcxGridDBBandedColumn
            Caption = 'Margem Atual'
            DataBinding.FieldName = 'MARBR2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 5
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVVE2: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Novo'
            DataBinding.FieldName = 'NOVVE2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVVE1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVVE1CustomDrawCell
            GroupSummaryAlignment = taRightJustify
            HeaderAlignmentHorz = taRightJustify
            HeaderGlyphAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 5
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbAtuPrecosATUPRE: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o'
            DataBinding.FieldName = 'ATUPRE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Properties.OnChange = cxbAtuPrecosATUPREPropertiesChange
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taRightJustify
            Width = 66
            Position.BandIndex = 11
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosSALDOS: TcxGridDBBandedColumn
            Caption = 'Estoque'
            DataBinding.FieldName = 'SALDOS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DecimalPlaces = 3
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 1
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPREVE1: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Atual'
            DataBinding.FieldName = 'PREVE1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 4
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPREVE2: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Atual'
            DataBinding.FieldName = 'PREVE2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 5
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosMARBR3: TcxGridDBBandedColumn
            Caption = 'Margem Atual'
            DataBinding.FieldName = 'MARBR3'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 6
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVVE3: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Novo'
            DataBinding.FieldName = 'NOVVE3'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVVE1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVVE1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 6
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPREVE3: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Atual'
            DataBinding.FieldName = 'PREVE3'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 6
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosMARBR4: TcxGridDBBandedColumn
            Caption = 'Margem Atual'
            DataBinding.FieldName = 'MARBR4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 7
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVVE4: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Novo'
            DataBinding.FieldName = 'NOVVE4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVVE1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVVE1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 7
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPREVE4: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Atual'
            DataBinding.FieldName = 'PREVE4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 7
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosMARBR5: TcxGridDBBandedColumn
            Caption = 'Margem Atual'
            DataBinding.FieldName = 'MARBR5'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 8
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVVE5: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Novo'
            DataBinding.FieldName = 'NOVVE5'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVVE1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVVE1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 8
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPREVE5: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Atual'
            DataBinding.FieldName = 'PREVE5'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 8
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosMARBR6: TcxGridDBBandedColumn
            Caption = 'Margem Atual'
            DataBinding.FieldName = 'MARBR6'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 9
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVVE6: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Novo'
            DataBinding.FieldName = 'NOVVE6'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVVE1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVVE1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 9
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPREVE6: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Atual'
            DataBinding.FieldName = 'PREVE6'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 9
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosMARBR7: TcxGridDBBandedColumn
            Caption = 'Margem Atual'
            DataBinding.FieldName = 'MARBR7'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 10
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVVE7: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Novo'
            DataBinding.FieldName = 'NOVVE7'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVVE1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVVE1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 10
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPREVE7: TcxGridDBBandedColumn
            Caption = 'Pr. Venda Atual'
            DataBinding.FieldName = 'PREVE7'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 10
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosDIFER1: TcxGridDBBandedColumn
            Caption = 'Diferen'#231'a (%)'
            DataBinding.FieldName = 'DIFER1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 4
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxbAtuPrecosDIFER2: TcxGridDBBandedColumn
            Caption = 'Diferen'#231'a (%)'
            DataBinding.FieldName = 'DIFER2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 5
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxbAtuPrecosDIFER3: TcxGridDBBandedColumn
            Caption = 'Diferen'#231'a (%)'
            DataBinding.FieldName = 'DIFER3'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 6
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxbAtuPrecosDIFER4: TcxGridDBBandedColumn
            Caption = 'Diferen'#231'a (%)'
            DataBinding.FieldName = 'DIFER4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 7
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxbAtuPrecosDIFER5: TcxGridDBBandedColumn
            Caption = 'Diferen'#231'a (%)'
            DataBinding.FieldName = 'DIFER5'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 8
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxbAtuPrecosDIFER6: TcxGridDBBandedColumn
            Caption = 'Diferen'#231'a (%)'
            DataBinding.FieldName = 'DIFER6'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 9
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxbAtuPrecosDIFER7: TcxGridDBBandedColumn
            Caption = 'Diferen'#231'a (%)'
            DataBinding.FieldName = 'DIFER7'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 100
            Position.BandIndex = 10
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxbAtuPrecosDIFER8: TcxGridDBBandedColumn
            Caption = 'Diferen'#231'a (%)'
            DataBinding.FieldName = 'DIFCOM'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 70
            Position.BandIndex = 2
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosDIFER9: TcxGridDBBandedColumn
            Caption = 'Diferen'#231'a (%)'
            DataBinding.FieldName = 'DIFCUS'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Options.Editing = False
            Width = 70
            Position.BandIndex = 3
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVBR1: TcxGridDBBandedColumn
            Caption = 'Nova Margem'
            DataBinding.FieldName = 'NOVBR1'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVBR1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVBR1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 4
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVBR2: TcxGridDBBandedColumn
            Caption = 'Nova Margem'
            DataBinding.FieldName = 'NOVBR2'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVBR1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVBR1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 5
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVBR3: TcxGridDBBandedColumn
            Caption = 'Nova Margem'
            DataBinding.FieldName = 'NOVBR3'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVBR1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVBR1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 6
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVBR4: TcxGridDBBandedColumn
            Caption = 'Nova Margem'
            DataBinding.FieldName = 'NOVBR4'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVBR1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVBR1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 7
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVBR5: TcxGridDBBandedColumn
            Caption = 'Nova Margem'
            DataBinding.FieldName = 'NOVBR5'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVBR1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVBR1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 8
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVBR6: TcxGridDBBandedColumn
            Caption = 'Nova Margem'
            DataBinding.FieldName = 'NOVBR6'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVBR1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVBR1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 9
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosNOVBR7: TcxGridDBBandedColumn
            Caption = 'Nova Margem'
            DataBinding.FieldName = 'NOVBR7'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00;-0.00'
            Properties.OnValidate = cxbAtuPrecosNOVBR1PropertiesValidate
            OnCustomDrawCell = cxbAtuPrecosNOVBR1CustomDrawCell
            HeaderAlignmentHorz = taRightJustify
            Width = 100
            Position.BandIndex = 10
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosTIPALT: TcxGridDBBandedColumn
            Caption = 'Recalcular'
            DataBinding.FieldName = 'TIPALT'
            PropertiesClassName = 'TcxComboBoxProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DropDownListStyle = lsFixedList
            Properties.ImmediatePost = True
            Properties.Items.Strings = (
              'Margem'
              'Pre'#231'o')
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taCenter
            Width = 65
            Position.BandIndex = 11
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxbAtuPrecosPJAATU: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o j'#225' atualizado'
            DataBinding.FieldName = 'PJAATU'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ReadOnly = True
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            HeaderAlignmentHorz = taCenter
            Width = 109
            Position.BandIndex = 11
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxbAtuPrecosORDITE: TcxGridDBBandedColumn
            Caption = 'Ordem'
            DataBinding.FieldName = 'ORDITE'
            Visible = False
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            VisibleForCustomization = False
            Position.BandIndex = 0
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxbAtuPrecosITESIM: TcxGridDBBandedColumn
            DataBinding.FieldName = 'ITESIM'
            Visible = False
            OnCustomDrawCell = cxbAtuPrecosCODITECustomDrawCell
            VisibleForCustomization = False
            Position.BandIndex = 0
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxbAtuPrecosGERPED: TcxGridDBBandedColumn
            DataBinding.FieldName = 'GERPED'
            Visible = False
            Position.BandIndex = 0
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
        end
        object cxgItensLevel: TcxGridLevel
          GridView = cxbAtuPrecos
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 1342
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        ParentBackground = False
        ParentColor = True
        TabOrder = 2
        object chkNOVIPI: TDBCheckBox
          Left = 11
          Top = 12
          Width = 686
          Height = 17
          BiDiMode = bdLeftToRight
          Caption = 
            'Utilizar os novos percentuais de IPI e Substitui'#231#227'o para o c'#225'lcu' +
            'lo do novo Pre'#231'o de Custo e atualiz'#225'-los no Cadastro de Produtos' +
            ' '
          DataField = 'COT_NOVIPI'
          DataSource = dtsCotGer
          ParentBiDiMode = False
          TabOrder = 0
          ValueChecked = 'S'
          ValueUnchecked = 'N'
        end
      end
    end
  end
  object pgbProgresso: TProgressBar [4]
    Left = 0
    Top = 681
    Width = 1350
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 4
    Visible = False
  end
  object chkSuspendeOrdenacao: TCheckBox [5]
    Left = 799
    Top = 702
    Width = 97
    Height = 17
    Caption = 'chkSuspendeOrdenacao'
    TabOrder = 5
    Visible = False
    OnClick = chkSuspendeOrdenacaoClick
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1072
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 912
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 976
    Top = 8
  end
  object cxImageList1: TcxImageList
    SourceDPI = 96
    FormatVersion = 1
    DesignInfo = 24642208
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000004463
          D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463
          D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463
          D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF4463D8FF4261D3F94463D8FF4463D8FF4463D8FF4463
          D8FF4361D5FB4463D8FF4463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF3751B0D0090D1D22344CA5C34463D8FF4463D8FF3147
          9BB70B1023293C57BFE14463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4260D0F6080C191E0000000003050B0D344CA5C331479BB70203
          0607000000000D132A314463D7FE4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF31489DB90304080A0000000003050B0D020306070000
          000004060D0F354DA9C74463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF4463D8FF31489DB90304080A00000000000000000406
          0D0F354DA9C74463D8FF4463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF4463D8FF31479BB70203060700000000000000000305
          0A0C344CA5C34463D8FF4463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF31479BB7020306070000000004050C0E0304080A0000
          000003050A0C344CA5C34463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4261D3F9090D1C210000000004060D0F354DA9C731489DB90304
          080A000000000C11262D4362D6FD4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF3A54B7D80B102329354DA9C74463D8FF4463D8FF3148
          9DB90B11242B3C57BEE04463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF4463D8FF4361D5FB4463D8FF4463D8FF4463D8FF4463
          D8FF4361D5FB4463D8FF4463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463
          D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF00000000000000004463
          D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463
          D8FF4463D8FF4463D8FF4463D8FF4463D8FF4463D8FF00000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000020000000A000000140000001B000000170000000D000000060000
          000E0000001D000000250000001F000000110000000400000000000000000000
          00020000000E291F177C4D3B2CCD664D39F94B392AD0271D168600000029261C
          148B483526D75E4732FA463426DA241B13930000001D00000004000000000000
          00072A2119789C8B7EFCC6BFB8FFE3E1DEFFC3BCB5FF968679FD403023C99384
          77FDBEB6AFFFDAD7D5FFBBB3ADFF8E7F71FD241B139200000011000000000000
          000E544031CACAC1BBFF9F8A7AFF7D614CFF785E48FF745945FF6F5541FF6B52
          3DFF684E3AFF654C37FF857364FFBCB3ADFF473425D90000001F000000031008
          0532755944FDE8E6E4FF896E56FFA8A29DFF826651FFFFFFFFFFDAD8D5FFD4D3
          D1FF7A5F49FF9B9590FF684E3AFFDBD8D6FF5F4834FA000000230000000C6D39
          24AC885D46FFCDC5BEFFA89382FF8D715AFF896D56FF866A54FF816550FF7D61
          4CFF795E48FF745944FF8D7969FFBFB7B0FF493627D50000001B3B1F1164C66B
          45FEA56647FFA49485FFCDC4BEFFE8E6E4FFCBC2BCFF9E8E80FF744D37FF9C8B
          7DFFC5BCB6FFE0DEDCFFC2B9B3FF958477FD261D15870000000E713B21AAD17B
          4DFF9E713FFF6D5C33FF5F5936FF745C45FF6E583BFF976042FFBF6844FF6D56
          2DFF605332FF6D523DFF724D3AFC281E168E00000014000000039D522EDDA77F
          46FF54691DFFC1935CFFBE915AFFC5905BFFD6945FFFE2925FFFCE7D4FFF406B
          11FF2F8F28FF568044FFB9634FFD000000270000000300000000B76236FB6271
          27FF9D8C50FFAE9D5BFFE3BC7AFFF2BF7EFFF1B678FFEEA86FFFCE8B58FF4480
          27FF4AB25BFF67905CFFC86E56FF000000200000000000000000A0552FDC637C
          2AFF3C731DFF2E7E15FFA5A460FFE9C986FFF3C684FFF1BA7AFFD59964FF6887
          45FF5FC886FF7D8B60FFC26A50F90000001A0000000000000000753F23A59285
          40FF298818FF28971CFF43892BFFAFAA6BFFE5C785FFF1C382FFD8A56BFF8095
          5DFF7F8F60FFB87350FF9E563FD80000001200000000000000003E22125BB972
          3FFC6E9C43FF43A138FF5EB556FF78B96EFFA9AA70FFDEC07EFFB6985BFF427D
          14FF8E7936FFCE7752FE4C281B80000000090000000000000000000000056939
          1E94B4834CFF96B773FF81AE79FF94B087FFA8B592FFA39C5DFF3C8213FF5B7F
          23FFC87F52FF7F462FB70000001100000002000000000000000000000001110A
          051C69391F94BC7847FCC4AE82FFB6B38EFFBDBFA7FF8A9B67FF8E8E4DFFBF7C
          4BFE724027A91008052700000003000000000000000000000000000000000000
          0001000000053E22125B753F23A5A0562FDCB86337FB9E532EDD713C21AA3B1F
          11640000000C0000000300000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000020000
          000A000000160000001B000000170000000B0000000200000000000000010000
          00060000000B0000000F0000000C0000000600000001000000000000000F2616
          1072583424D8693D2AFF4D2C1FD91D110B750000001200000003000000082416
          1162513023CF613927FF45281BD01A0F0A630000000900000001291A136DA380
          70FFD4C5BDFFEDE5E1FFCFBEB7FF907163FF1F120C770000000F2C1C1663A181
          72FFD4C6BEFFEEE8E4FFCDC0B8FF866A5DFF190E096000000005734937DEE3D7
          D1FFCEAE9EFFAF7957FFD0B39EFFD7C9C3FF553324E00000001B77503FD8E2D7
          D2FFD0AD9BFFB37753FFD2B29AFFD6CBC5FF4A2B1ED90000000A8E5A47FBF8F6
          F4FFAE725BFFE7AF66FFB27F5EFFF0EBE8FF744835FF000000489A6B55FFF8F6
          F3FFB27056FFE8AF64FFB67E59FFEAE3DFFF613B29FA0000000B90604DF8F1E8
          E4FFD2B0A5FFAA6C53FFD4B6A7FFCDC0BAFF71422FFF4C2920FF80513DFFF1E8
          E3FFD3ADA1FFAE684FFFD4B2A1FFC5B6AFFF6A4231F700000009583C31A2CAAF
          A3FFF7F2EEFFFDFCFBFFEAE0DAFF9E847AFF774835FF663E36FF855944FFE8D9
          CFFFF7F0EDFFFCFAF9FFDFD4CEFF8A6657FF452D229A000000050805041D9F72
          5DF8E8DBD4FFE6D7CEFFCDB7AAFF8B6B5EFF7D4C3AFF865F56FF8B5F4BFFE9D8
          CEFFEADCD4FFCFB9ACFF997B6DFF966A54F70705041600000001000000076047
          3BA4D0B7ADFFEEE3DFFFD5C1B7FF93766CFF82533FFF734635FF926550FFECE0
          D9FFEBDED8FFC4B0A5FF9B7868FF5F45389D0000000400000000000000022219
          1541B89383FFF3EBE8FFD9C9C2FFA99389FFA67966FF00000026B48B76FFF0E7
          E3FFEADED9FFBDA79FFFA67D6CFF211915390000000100000000000000000000
          0007846554C6DDCCC4FFE6DCD8FFC2A99EFFA67E69F90000000CB38E79F8E0D1
          C9FFE9DFDAFFBCA497FF846555C2000000030000000000000000000000000000
          0002130F0D237D6152B7AF8673FA7B6050B9130E0C270000000414100E1E8365
          58B3B68F79F9806455B3130F0D1E000000010000000000000000000000000000
          0000000000010000000400000006000000050000000200000000000000000000
          0001000000010000000100000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000900000012000000120000
          0009000000020000000000000000000000000000000000000000000000000000
          0000000000030000000A0000000A0000000B2519156F68473BFF67443BFF1D13
          0F700000000C0000000B0000000C000000050000000100000000000000000000
          00030403021A543B33C738251EB30D0907454C362DC4B5A198FFAB958AFF3E29
          23C50D080748311F1AB13A241ECE030202220000000400000000000000000000
          00085A4138C9C7B9B0FFA8958BFF6C4F47FF715044FECABAB0FFC6B5AAFF6142
          37FE6B5047FE9C857AFFA89388FF3B241FCB0000000B00000000000000000000
          00074C3930ABC0AEA7FFE3DBD5FFD2C3BAFFC1AFA6FFCFC0B7FFCEBEB5FFBCAA
          9FFFCAB9AEFFC9B8ADFF9F897FFF36221DB20000000A00000000000000010000
          0007110C0B368D6F65FCEAE3DFFFDACDC6FFD8CCC3FFE3D9D3FFE7E0DAFFE1D6
          D0FFD2C3B9FFCDBCB3FF705449FE0D0907410000000A00000002000000042A1E
          1A6B4C372EBB846356FED9CEC8FFE3DAD5FFCDBEB7FF8E6F62FF947567FFD0C0
          B9FFE3DAD3FFC8B7ADFF6A4940FF47312AC22418147100000007000000088D6D
          60FFD8CCC7FFEEE8E5FFEBE6E0FFEAE3DDFF7F6257FF2219155E241B175E9374
          67FFEBE4DFFFD6C8C0FFD3C6BDFFB9A59BFF78574BFF0000000D000000079373
          64FFD9CECAFFF6F3F2FFFAF7F6FFEFEAE5FF76574DFF1D1411551E1613568869
          5DFFEFE9E6FFDDD2CBFFD8CAC3FFC7B8B1FF7E5B4FFF0000000C000000033428
          245F665046B5937467FEECE6E3FFF0ECE8FFCEC2BDFF856961FF886D65FFD2C7
          C2FFECE4DFFFD9CFC9FF856458FD5A443AB92B201C6102010108000000000000
          000316110F2EA78B7EFDF6F4F1FFF3EFECFFF2EEEAFFF3EFECFFF0EBE7FFEFEA
          E6FFEFEBE7FFECE5E0FF83665BFD110C0B390000000600000001000000000000
          0003685349AADCD1CBFFF8F6F3FFF8F5F3FFEBE4E1FFFDFCFBFFF3EEECFFE2D8
          D3FFFAF9F8FFF9F7F5FFC8B9B3FF4E3931B00000000500000000000000000000
          0002776055BDE5DDD8FFDCD0CBFFAC9183FD9E7E6EFDFBF8F8FFF5F1EEFF9979
          6AFDA3897EFCD7CBC5FFE0D6D1FF6E564CC20000000500000000000000000000
          00010605040D7C6458BF69544BA51713102B6F594EB2E1D7D2FFE0D6D1FF6D57
          4DB314100E2B614D44A4775E53C7050404110000000100000000000000000000
          0000000000000000000100000002000000023B302A5EA68676FFA58375FF3A2F
          295F000000030000000300000003000000010000000000000000000000000000
          0000000000000000000000000000000000000000000100000002000000030000
          0001000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000050000
          0008000000090000000900000009000000090000000900000009000000090000
          0009000000090000000900000009000000090000000800000005000000140000
          00260000002B0000002B0000002B0000002B0000002B0000002B0000002B0000
          002B0000002B0000002B0000002B0000002B00000026000000141A3B6CB0295C
          A8FF295CA8FF295CA8FF295CA8FF295CA8FF295CA8FF2E60AAFF2E60AAFF295C
          A8FF295CA8FF295CA8FF295CA8FF295CA8FF295CA8FF1A3B6AAE27589DEB84B6
          DDFF9ACDF0FF94CBEFFFA7D4F2FFB9DDF5FFCEE7F8FFD9E7F1FFD1E4F0FFB6DC
          F4FF94CBEFFF84C3EDFF78BEEBFF81C1ECFF7EB2DBFF27589DEB1B3D699E5586
          BEFFA7D3F0FF6DB9EAFF61B3E8FF61B3E8FFA3D3F2FF453F3EFF453F3EFFA3D3
          F2FF61B3E8FF61B3E8FF69B7E9FF87C2EAFF437BB8FF1B3C679C0205080E285B
          97DB7EA8D1FF9BD0F1FF72BCEBFF79C0ECFFA0D2F2FF7E858DFF7E858DFFA0D2
          F2FF7AC0ECFF73BDEBFF85C5EEFF6196C8FF285A96D90204070D000000000A16
          2437306DB1F9C0DAEDFFA4D6F2FF91CCF0FF95CDF1FF93C7E8FF93C7E8FF95CD
          F1FF91CCF0FF9BD1F1FF95C2E3FF306DB1F90A16243600000000000000000000
          00011837577C558DC2FFDCEFFAFF9FD4F1FFAFDBF4FF83939EFF83939FFFAFDB
          F4FF9DD3F1FFB3DDF5FF538CC2FF183654790000000100000000000000000000
          000001010205285D8DC273A6D1FFCFEBF9FFC0E3F7FF727071FF727071FFC0E3
          F7FFAFDDF5FF6EA3CFFF285B8BBF000001030000000000000000000000000000
          000000000000060F16213579B3EFA3CCE7FFDAEFFAFF665D5BFF665D5BFFCFEB
          F9FF99C6E4FF3578B2ED060E141F000000000000000000000000000000000000
          00000000000000000001142F435C5B9ACBFFDEF3FBFF766F6DFF766F6EFFD9F0
          FBFF5899CBFF132B3E5500000001000000000000000000000000000000000000
          000000000000000000000000000226587CA385B8DBFFDEF3FCFFDAF2FBFF84B7
          DBFF2555779D0000000200000000000000000000000000000000000000000000
          000000000000000000000000000003070A10377FAFDFA2CEE8FF9FCCE7FF367B
          AAD90306090E0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000010E212C3B4095CAFB4094C9FA0D1E
          2937000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000119394C5F1836495B0000
          0001000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0002000000070000000B0000000C0000000C0000000C0000000C0000000D0000
          000D0000000D0000000D0000000C000000080000000200000000000000000000
          000619563DBE207151FF207050FF206F4FFF216D4EFF206C4DFF216B4CFF216A
          4BFF21694BFF21684AFF21674AFF174935C00000000800000000000000000000
          000925825FFF53D0A8FF45CB9FFF44CB9FFF44CB9EFF64D7B3FF82E1C5FF63D7
          B2FF43CA9DFF42CA9CFF48CCA0FF1E7754FF0000000C00000000000000000000
          0009278662FF5CD4AEFF48CDA1FF58D2ABFF70DBBBFF1C724FFF1C7350FF7CE0
          C1FF66D8B4FF4CCEA4FF4ECFA3FF207956FF0000000C00000000000000000000
          00082B8A66FF65D7B3FF4ACEA3FF3E9F7CFF2B8360FF176745FF1A6D4BFF348C
          6CFF69C5A7FF65D7B4FF53D1A7FF227C58FF0000000B00000000000000000000
          00072C8D6AFF6EDBBAFF4ECFA5FF227957FF43A886FF63C4A5FF207756FF2078
          55FF257D59FF61D6B1FF58D3ACFF237E5BFF0000000A00000000000000000000
          000730916DFF77DEC0FF51D1A8FF60D4B0FF4CA887FF27805CFF227A57FF1F74
          51FF2B8362FF4DCFA5FF5ED6B0FF26805EFF0000000900000000000000000000
          0006329471FF80E1C5FF54D2AAFF3F9F7DFF227A58FF247F5BFF287F5BFF48A9
          87FF77DBBEFF65D8B4FF65D8B4FF288361FF0000000900000000000000000000
          0005349875FF8BE6CCFF5ED9B4FF359471FF1F7351FF257E5AFF7AD0B6FF54AB
          8EFF409978FF67DAB9FF6DDBBBFF2A8663FF0000000800000000000000000000
          0005389D79FF98EBD6FF63DCB9FF5CD0ADFF318C6AFF227956FF288460FF2980
          5EFF42AA87FF5FDAB6FF79E1C5FF2E8B68FF0000000700000000000000000000
          000440A380FFA1EDD9FF69DFBDFF68DFBDFF68DEBCFF1E6F4DFF1D6F4DFF66DD
          BBFF65DCBBFF65DDBAFF80E4C9FF36926EFF0000000700000000000000000000
          000445A884FFA6F0DEFFA6F0DEFFA6EFDDFFA6EFDDFFA5EFDCFFA4EFDCFFA4EF
          DCFFA3EFDCFFA3EEDCFFA2EEDBFF3A9772FF0000000600000000000000000000
          000348AC86FF389976FF379976FF379875FF379774FF369673FF369673FF3595
          72FF349471FF339370FF32936FFF3D9A76FF0000000500000000000000000000
          000252B38FFFAFD3C5FFFEFEFEFFFDFCFCFFFCFAF9FFFAF8F6FFF8F5F3FFF7F2
          F0FFF6F0ECFFF4EDE9FFF2ECE7FF47A27FFF0000000400000000000000000000
          00013F876DBF55B693FF55B693FF56B592FF55B592FF55B592FF55B492FF55B4
          91FF55B491FF54B490FF54B390FF3E856BC00000000300000000000000000000
          0000000000010000000200000002000000020000000200000003000000030000
          0003000000030000000300000003000000020000000100000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          00000000000000000002000000070000000C0000001000000012000000110000
          000E000000080000000200000000000000000000000000000000000000000000
          000100000004000101120D2A1D79184E36C6216B4BFF216B4BFF216C4BFF1A53
          3AD20F2F21840001011500000005000000010000000000000000000000000000
          0005050F0A351C5B40DC24805CFF29AC7EFF2CC592FF2DC894FF2DC693FF2AAE
          80FF258560FF1A563DD405110C3D00000007000000010000000000000003040E
          0A31206548ED299D74FF2FC896FF2EC996FF56D4ACFF68DAB5FF3BCD9DFF30C9
          96FF32CA99FF2BA479FF227050F805110C3D00000005000000000000000A1A57
          3DD02EA57CFF33CA99FF2EC896FF4CD2A8FF20835CFF00673BFF45BE96FF31CB
          99FF31CB98FF34CC9CFF31AD83FF1B5C41D300010113000000020B23185E2E8A
          66FF3BCD9EFF30CA97FF4BD3A9FF349571FF87AF9DFFB1CFC1FF238A60FF45D3
          A8FF36CF9FFF33CD9BFF3ED0A3FF319470FF0F32237F00000007184D37B63DB3
          8CFF39CD9FFF4BD5A9FF43A382FF699782FFF8F1EEFFF9F3EEFF357F5DFF56C4
          A1FF43D5A8FF3ED3A4FF3CD1A4FF41BC95FF1B5C43CD0000000B1C6446DF4BCA
          A4FF44D2A8FF4FB392FF4E826AFFF0E9E6FFC0C3B5FFEFE3DDFFCEDDD4FF1B75
          4FFF60DCB8FF48D8ACFF47D6AAFF51D4ACFF247A58F80000000E217050F266D9
          B8FF46D3A8FF0B6741FFD2D2CBFF6A8F77FF116B43FF73967EFFF1E8E3FF72A2
          8BFF46A685FF5EDFBAFF4CD9AFFF6BE2C2FF278460FF020604191E684ADC78D9
          BEFF52DAB1FF3DBA92FF096941FF2F9C76FF57DEB8FF2D9973FF73967EFFF0EA
          E7FF4F886CFF5ABB9AFF5BDEB9FF7FE2C7FF27835FF80000000C19523BAB77C8
          B0FF62E0BCFF56DDB7FF59DFBAFF5CE1BDFF5EE2BEFF5FE4C1FF288C67FF698E
          76FFE6E1DCFF176B47FF5FD8B4FF83D5BDFF1E674CC60000000909201747439C
          7BFF95ECD6FF5ADFBAFF5EE2BDFF61E4BFFF64E6C1FF67E6C5FF67E8C7FF39A1
          7EFF1F6D4AFF288B64FF98EFD9FF4DAC8CFF1036286D00000004000000041C5F
          46B578C6ADFF9AEED9FF65E5C0FF64E7C3FF69E7C6FF6BE8C8FF6CE9C9FF6BEA
          C9FF5ED6B6FF97EDD7FF86D3BBFF237759D20102010C0000000100000001030A
          0718247B5BDA70C1A8FFB5F2E3FF98F0DAFF85EDD4FF75EBCEFF88EFD6FF9CF2
          DDFFBAF4E7FF78CDB3FF2A906DEA0615102E0000000200000000000000000000
          0001030A07171E694FB844AB87FF85D2BBFFA8E6D6FFC5F4EBFFABE9D8FF89D8
          C1FF4BB692FF237F60CB05130E27000000030000000000000000000000000000
          000000000001000000030A241B411B60489D258464CF2C9D77EE258867CF1F71
          56B00E3226560000000600000002000000000000000000000000}
      end>
  end
  object dtsCotGer: TDataSource
    Left = 860
    Top = 347
  end
  object dtsCotCfo: TDataSource
    Left = 788
    Top = 347
  end
  object cxStyleRepository2: TcxStyleRepository
    Left = 152
    Top = 296
    PixelsPerInch = 96
    object cxStyle3: TcxStyle
      AssignedValues = [svColor]
      Color = 14869218
    end
    object cxStyle1: TcxStyle
      AssignedValues = [svColor]
      Color = clMoneyGreen
    end
  end
  object dtsItens: TDataSource
    Left = 348
    Top = 243
  end
  object ppmComunicaPitStop: TPopupMenu
    Left = 364
    Top = 402
    object mnuComPitStop: TMenuItem
      Caption = 'Log Comunica'#231#227'o Pit Stop'
      OnClick = mnuComPitStopClick
    end
    object mnuPitStopParado: TMenuItem
      Caption = 'Servi'#231'o Parado(Reiniciar)'
      OnClick = mnuPitStopParadoClick
    end
  end
  object mnuIntegracaPitStop: TPopupMenu
    Left = 492
    Top = 666
    object mnuBuscapreco1: TMenuItem
      Caption = 'Buscar pre'#231'os 1'#170'. cota'#231#227'o'
      OnClick = mnuBuscapreco1Click
    end
    object mnuBuscapreco2: TMenuItem
      Caption = 'Buscar pre'#231'os 2'#170'. cota'#231#227'o'
      OnClick = mnuBuscapreco2Click
    end
    object mnuCarregaPreco: TMenuItem
      Caption = 'Carregar pre'#231'os da cota'#231#227'o'
      OnClick = mnuCarregaPrecoClick
    end
    object mnuRefazCotacao: TMenuItem
      Caption = 'Refazer cota'#231#227'o'
      OnClick = mnuRefazCotacaoClick
    end
  end
  object mnuIntegracao: TPopupMenu
    Left = 484
    Top = 410
    object mnuBuscaPreco: TMenuItem
      Caption = 'Buscar pre'#231'os'
      OnClick = mnuBuscaPrecoClick
    end
    object mnuReiniciaCota: TMenuItem
      Caption = 'Refazer cota'#231#227'o'
      OnClick = mnuReiniciaCotaClick
    end
  end
  object cxEditRepository1: TcxEditRepository
    Left = 600
    Top = 184
    PixelsPerInch = 96
    object cxEditRepository1ButtonItem1: TcxEditRepositoryButtonItem
      Properties.Buttons = <
        item
          Default = True
          Glyph.SourceDPI = 96
          Glyph.Data = {
            89504E470D0A1A0A0000000D4948445200000020000000200806000000737A7A
            F400000035744558745469746C6500546563686E6F6C6F67793B53657474696E
            67733B4F7074696F6E733B437573746F6D697A3B50726F706572746965730FB5
            035C0000086A49444154785EA55707509557167E10B1AF1A35666349D9D58C99
            D5CCEAAE63A2D8161224C24250411050101404441E20451E55AA0F1011F419E1
            05FB121B0A968048513AD2A4166902224A918EC2B7E7FEF33F86D1C944867FE6
            9BFBEEFDEFBDE7BBE73FE73BF70944FE52818BDFAF04A9E0B06FA4E0B04FA480
            1E3982BCB9D0E713550D0305D697417193FA44230BD13CEA7FC4E6B0315BB770
            81D0354C20149D10D8884205B207C09F82191DE90C0F83336EE71EBED2C14312
            E5218EEAB3770B97D0D804DEA08250142A11F945F6D9B81C3FBB4FE8B34A4662
            787858C060ED1C3236024EDE6704FCE29193DBBB9F3C9596FD04038383B81E97
            8A034EC1421A9F62E520165E8D4DC6C0C020D2B28A60E9181CC193931BA2F543
            43C3024B87A0B11170F03C3D629CC7043A5D48D2A37CF4F40FA09F489C94DE80
            8D4B28C223AF6370F02D7AFA0691909C03735B7FE6EF49CC3BB2F5E67647C746
            40766A7E93096C434B07B1F78DDBA9E82543ADAFBAE8C46F4027C4E09B217474
            F5E275771FAEDC7A803D07BC98BFA713261326CABC315602F2A6D6DE4B0E3807
            1F35B70BB032B70D703BEC7DBAA7A6BE199D5D7D78DEDAC9A1B9B503CD2F3AD0
            4460FD9617ED70F33BFDC6D0CC35C068BF47949185A7546BE7817FC9488C85C0
            044B87C013BF3FC8C6A56B0984783C7FD186EEDE01CE50634B3B1A9FB7E31987
            360E0DCD6DA87BD68AE6965788BA7C1B892939B84FD0DFEB12C57B43FE83096C
            DAAC3D53E872BCB3BBBB177DFD83E8A3006B7BDDC30C33438457A86F7E89DAA6
            97A869E480B2A7CD2828AB477155035EBC226FBC7C4D6D07CC84BE3DDFAD57FB
            8CC5C4071358BA6CD5E47D367E51D76293C8E5BDA86B7A853A66E819432BB20B
            2A60E724868E812D848E623CA4ECC82DA9456E712D728A6A3854D3BC9391D7B0
            DDD0FE04CB96317980673BC5C04CE4795C128D176D5DA86E6841757D0BAAEA5A
            E0203A869FB5F7FBD09C4FB7EA5A899DDD4238E39985D5C828A84615CD73F539
            0DF5EDE6229A3393A030D61890E75369B6B195D7407B47172A6A9FA3ACA61965
            D54D30B5707F3B77DEFC45F47ECE578BFFB178EF012F8E58DAE34AA4E55672DE
            D23172643BCD274C63071A7310B2853B8C1DC5C74F47739FA1840C175534129E
            417CFC1C761ADB7BD19C0586A60EFE81A1E7514B9F2735BB0229D9657852DE00
            375F0954344CDC68CEC784896322F0CDF2D53374F7385DBA1293480233805A3A
            517E593DA10EF9250C4F111E71158EEE27202141AAAC69426955231E64942231
            A30489E925A8696845D82FD1F849CB5C3A6BF6A733655EF82002CBFEB976CEEE
            FD1E1D14C5946E6D9C7B0B4AEB29B86A919E578DF4FC2A945637E239D3014ACB
            92CA262465952121AD9808142323BF12A9B9E5785251876D06763D7FFB7AC582
            D15AF02198A2B5D3E6A4F4422C82C22F2130EC221EB28DF3AAC84029EEA71773
            884F2B42FC238642DC7B58C8F5EFA5E6C13DE00C824E5D4698F43A94D5F79C27
            03337802F21F4A4261FD8F3ACBD5B52D8E6CD6343DA4A269E26F64E1DE9D9856
            486E2EC13D3278970CDE492DC09D9402DC26DC4D2D44ECFD6CE89B8AFAD7FFA8
            17BA49D550A2A4667C71E5F7AADFB103C9AAE7E8923D82771F7E8202BFF02F84
            794A5B7605F8874421B3A00AB7930B90422E4EA7DF0F324B71F3412EE71167AF
            70AC53D60D61C149984398C567C124B700E92E9F90CBF03E7619AEFE91BBF8FD
            0923C4E4DC03A204DCA3A92BE40BD2089119CA6A466289F41AF24BEBC86809AC
            1D03A1BAD5826BE31F169117F2E11772168ACABAC798F1754A6A733D83CE2579
            88CF5D34B3F6FA96DA9B2515F528A1B810F9496F19EE7558EEE27BE6BCC82F22
            6D83B2E6ECD1A92A50D7B1167476F77224F817D394D48CC2CE9C8BA1202CC791
            A028909BC3697CC9BA1F742581611770233E0B01949EEB7ED03BC952CF5D7CF6
            7E554D230A9E3C4568C48D212230D4DFCF2AE96BB8F94B87822557DE64D35EC5
            44C8C1F35432AF3BF21C812DDB2C05EDAF7B046D9D3D23A2B4F2FB2DAB376E36
            94AA695B766D54DD7593C6FECA0CB176838AC14D552DF3EEB5CABA51CB56FE67
            0DFB6C22DF88E882E26A74500D69EFEC467D632B776F686EE9A08CAAA5B23EC0
            95F0B8840CE89A385F1F2DD70255ADFD02152D7381CACF66A3BD30993073C117
            DF7C3EE79385F3585F162753A7CF9AF3D9C2255FF284A631E819DBAE0C3E7565
            A8ADA39B956C563159CB54926904B5ADA8A0026679E8E8D09A4D1A8A8CF41FA5
            EAE87898302A70E4DF199FC8BF9B64ED1CB8DBCE3D2CCEE9C82FC3CFA86A3650
            314B487E0C4BDBA3B0B2152329AD00E5643C39E309AC1C8387F65A7BDFD33771
            349EBFE8EFD3655EF80312EFE0DD71BE881DF294E071612527E13DBD03ECB424
            DDAE58B361BBBEA2928E81D9C100D413A9D4AC0A24503AC7C56762EF415F300F
            73870130568C4EDFA942511872F2CBB90B4A556D33CAAB9BB1CFC61FCA3F199A
            A8A8EF3675703B854A2A6EF752483B92F270E6523C8C2DBDC0A7EDB8094C52DF
            BEDF5253EF60BC85BD78383DB78C4BDDF8943C387948E0EA27452209591ED594
            8B31A9ECBE00552DB314CA2A217F97FC683C04E4F87898B166A3FA5A478F136F
            ABA98E2493582592505121E3AA6A76510DE292F271ED6E36F44C0E0F2D5EFA6F
            155A33974F45B9F110905D66A6EB9BBAFC76353605855445EF24E7E3424C0A6E
            DE7F8C98DF73F06B7422A26F67E27F7159F00A3A8BB54A3A31ECEE4150183701
            3E0EA6E99B1E4E8F4BC8C231C96FD036B483DE1EE7E1AB77B37039361D5BB659
            0C6BEFB21F763F2A4540783456AFDF9A29FBFEE32520278B83455F2E5DB8DDC0
            364D5179C7ADAFBE5EB1E5BFDA960F232EDE4190E42A53CB475F2CFE566395A2
            E60D42CEC773172C66C1CBD68E97C07BC2C58BD3BC4DAA3B0F6AE81E84C60E6B
            AC58BDD98657D2B9FCFBA9A345689C04DEFB67A5C09399C188F098C98DBD2F6A
            827110F853F1E2D59261B4D1F7A5F7FF2C19F2185910BA830000000049454E44
            AE426082}
          Kind = bkGlyph
        end>
      Properties.ViewStyle = vsButtonsOnly
      Properties.OnButtonClick = cxEditRepository1ButtonItem1PropertiesButtonClick
    end
  end
end
