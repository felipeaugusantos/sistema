inherited frmCadEstruturasIndustrial: TfrmCadEstruturasIndustrial
  Left = 207
  Top = 209
  Width = 1022
  Height = 798
  Caption = 'Cadastro de F'#243'rmulas'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1022
  ExplicitHeight = 798
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 727
    Width = 1016
    Height = 26
    TabOrder = 2
    ExplicitTop = 727
    ExplicitWidth = 1016
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 944
      Height = 22
      ExplicitWidth = 944
      ExplicitHeight = 22
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 100
        Height = 22
        Align = alLeft
        Caption = '[ F10 ] Fechamento'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnApaga: TBitBtnLocked
        Left = 100
        Top = 0
        Width = 112
        Height = 22
        Align = alLeft
        Caption = '[ F2 ] Apaga Estrutura'
        TabOrder = 1
        OnClick = btnApagaClick
      end
      object btnEstrutura: TBitBtnLocked
        Left = 212
        Top = 0
        Width = 112
        Height = 22
        Align = alLeft
        Caption = '[ F3 ] Mostra Estrutura'
        TabOrder = 2
        OnClick = btnEstruturaClick
      end
      object btnComentario: TBitBtnLocked
        Left = 324
        Top = 0
        Width = 103
        Height = 22
        Align = alLeft
        Caption = '[ Insert ] Comentario'
        TabOrder = 3
        OnClick = btnComentarioClick
      end
      object btnMoveCima: TBitBtnLocked
        Left = 427
        Top = 0
        Width = 95
        Height = 22
        Align = alLeft
        Caption = 'Move Item p/ Cima'
        TabOrder = 4
        OnClick = btnMoveCimaClick
      end
      object btnMoveBaixo: TBitBtnLocked
        Left = 522
        Top = 0
        Width = 95
        Height = 22
        Align = alLeft
        Caption = 'Move Item p/ Baixo'
        TabOrder = 5
        OnClick = btnMoveBaixoClick
      end
      object btnImprimir: TBitBtnLocked
        Left = 617
        Top = 0
        Width = 79
        Height = 22
        Align = alLeft
        Caption = '[ F5 ] Imprimir'
        TabOrder = 6
        OnClick = btnImprimirClick
      end
      object btnSubstituir: TBitBtnLocked
        Left = 696
        Top = 0
        Width = 81
        Height = 22
        Align = alLeft
        Caption = '[ F6 ] Substituir'
        TabOrder = 7
        OnClick = btnSubstituirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 946
      Top = 2
      Width = 68
      Align = alRight
      ExplicitLeft = 946
      ExplicitTop = 2
      ExplicitWidth = 68
    end
  end
  inherited pnlStatus: TPanel
    Top = 753
    Width = 1016
    TabOrder = 3
    ExplicitTop = 753
    ExplicitWidth = 1016
    inherited pnlNomeForm: TPanel
      Left = 845
      ExplicitLeft = 845
    end
    inherited pnlInfo: TPanel
      Width = 845
      ExplicitWidth = 845
    end
  end
  object pnlProdutos: TPanel [2]
    Left = 0
    Top = 0
    Width = 1016
    Height = 109
    Align = alTop
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 14
      Width = 87
      Height = 14
      Caption = 'Produto Estrutura:'
    end
    object Label5: TLabel
      Left = 40
      Top = 37
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label10: TLabel
      Left = 227
      Top = 36
      Width = 42
      Height = 14
      Alignment = taRightJustify
      Caption = 'Unidade:'
    end
    object Label8: TLabel
      Left = 76
      Top = 60
      Width = 20
      Height = 14
      Caption = 'Cor:'
    end
    object Label9: TLabel
      Left = 4
      Top = 83
      Width = 92
      Height = 14
      Caption = 'C'#243'digo da F'#243'rmula:'
    end
    object Label15: TLabel
      Left = 223
      Top = 83
      Width = 354
      Height = 13
      Caption = '(Deixar esse campo vazio para o cadastro de uma nova f'#243'rmula.)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlue
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
    end
    object Label18: TLabel
      Left = 525
      Top = 40
      Width = 95
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data/Hora Cadastro'
    end
    object Label19: TLabel
      Left = 641
      Top = 40
      Width = 97
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data/Hora Altera'#231#227'o'
    end
    object lblDataDesenvolvimento: TLabel
      Left = 891
      Top = 40
      Width = 107
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Desenvolvimento'
    end
    object Label33: TLabel
      Left = 755
      Top = 40
      Width = 104
      Height = 14
      Alignment = taRightJustify
      Caption = 'Operador de Inclus'#227'o'
    end
    object edtDesProduto: TEditFocus
      Left = 151
      Top = 10
      Width = 488
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
    object edtProdutos: TEditFocus
      Tag = 99
      Left = 99
      Top = 10
      Width = 51
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      OnExit = edtProdutosExit
      OnKeyPress = edtProdutosKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtReferencia: TEditFocus
      Left = 99
      Top = 33
      Width = 118
      Height = 22
      Alignment = taLeftJustify
      AutoSize = False
      Color = 16768952
      Enabled = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtUnidade: TEditFocus
      Left = 275
      Top = 33
      Width = 41
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCor: TEditFocus
      Tag = 99
      Left = 99
      Top = 56
      Width = 51
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 4
      TabOrder = 5
      OnExit = edtCorExit
      OnKeyPress = edtCorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 4
      TipoTexto = ttNumerico
    end
    object edtDesCor: TEditFocus
      Left = 151
      Top = 56
      Width = 368
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFormula: TEditFocus
      Tag = 99
      Left = 99
      Top = 79
      Width = 118
      Height = 22
      Alignment = taLeftJustify
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 5
      TipoTexto = ttNumerico
    end
    object edtDtaCad: TEditFocus
      Left = 525
      Top = 56
      Width = 112
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDtaAlt: TEditFocus
      Left = 640
      Top = 56
      Width = 112
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object chkForEsp: TCheckBox
      Left = 787
      Top = 13
      Width = 122
      Height = 17
      TabStop = False
      Caption = 'Formula'#231#227'o Especial'
      TabOrder = 4
      OnClick = chkForEspClick
      OnKeyUp = chkForEspKeyUp
    end
    object edtDataDesenvolvimento: TDateEditFocus
      Left = 891
      Top = 56
      AutoSize = False
      Properties.Alignment.Horz = taCenter
      Properties.ButtonGlyph.SourceDPI = 96
      Properties.ButtonGlyph.Data = {
        424D360400000000000036000000280000001000000010000000010020000000
        000000000000C40E0000C40E0000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000806040FFC080
        60FFC08060FFC08060FFC08060FFC08060FFC08060FFC08060FFC08060FFC080
        60FFC08060FFC08060FFC08060FF806040FF0000000000000000C08060FFFFFF
        FFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FBFFFFF0FB
        FFFFF0FBFFFFF0FBFFFFF0FBFFFFC08060FF0000000000000000C08080FFFFFF
        FFFFFFFFFFFFC0A080FFC0DCC0FFC0A080FFC0DCC0FFC0A080FFC0DCC0FFC0A0
        80FFC0DCC0FFC0A080FFF0FBFFFFC08060FF0000000000000000C08080FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0FBFFFFF0FBFFFFC0DC
        C0FFC0DCC0FFC0DCC0FFF0FBFFFFC08080FF0000000000000000C08080FFFFFF
        FFFFFFFFFFFF8080C0FF4040C0FF4040C0FF4040A0FF8060C0FFFFFFFFFFC0A0
        80FFC0DCC0FFC0A080FFFFFFFFFFC08080FF0000000000000000C0A080FFFFFF
        FFFFFFFFFFFF4040C0FF4040C0FF4040C0FF4040C0FF4040A0FFFFFFFFFFF0FB
        FFFFF0FBFFFFF0FBFFFFFFFFFFFFC08080FF0000000000000000C0A080FFFFFF
        FFFFFFFFFFFF4060C0FF4060C0FFFFFFFFFF4040C0FF4040C0FFFFFFFFFFC0A0
        80FFF0FBFFFFC0A080FFFFFFFFFFC0A080FF0000000000000000C0A080FFFFFF
        FFFFFFFFFFFF4060C0FF4060C0FF4060C0FF4040C0FF4040C0FFFFFFFFFFF0FB
        FFFFF0FBFFFFF0FBFFFFFFFFFFFFC0A080FF0000000000000000C0A0A0FFFFFF
        FFFFFFFFFFFF8080E0FF4060C0FF4060C0FF4060C0FF8080C0FFFFFFFFFFC0A0
        A0FFF0FBFFFFC0A080FFFFFFFFFFC0A080FF0000000000000000C0A0A0FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC0A0A0FF00000000000000004060C0FF80A0
        E0FF8080E0FF8080E0FF8080E0FF8080E0FF4080E0FF4060E0FF4060E0FF4060
        E0FF4060E0FF4060E0FF8060E0FF4040A0FF00000000000000004060C0FF80A0
        E0FF8080E0FF8080E0FF8080E0FF8080E0FF8080E0FF8080E0FF4060E0FF4060
        E0FF4060E0FF4060E0FF8080E0FF4040A0FF00000000000000004060C0FF80A0
        E0FF80A0E0FF80A0E0FF80A0E0FF80A0E0FF80A0E0FF80A0E0FF80A0E0FF80A0
        E0FF8080E0FF8080E0FF8080E0FF4040A0FF00000000000000004040A0FF4060
        C0FF4060C0FF4060C0FF4040C0FF4040C0FF4040C0FF4040C0FF4040C0FF4040
        C0FF4040C0FF4040C0FF4040A0FF402080FF0000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000000}
      Properties.ClearKey = 46
      Properties.DateButtons = []
      Properties.MinDate = 2.000000000000000000
      Properties.ValidateOnEnter = False
      Properties.ValidationOptions = []
      StyleFocused.Color = clInfoBk
      TabOrder = 7
      Height = 22
      Width = 116
    end
    object edtOpeUltimaAlteracao: TEditFocus
      Left = 755
      Top = 56
      Width = 132
      Height = 22
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      TabOrder = 11
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object rdgStatus: TRadioGroup [3]
    Tag = 99
    Left = 645
    Top = 3
    Width = 136
    Height = 36
    Caption = 'Status'
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'Ativa'
      'Inativa')
    TabOrder = 4
    TabStop = True
    StyleElements = []
  end
  object PageControl: TPageControl [4]
    Left = 0
    Top = 142
    Width = 1016
    Height = 585
    ActivePage = tbsFormula
    Align = alClient
    TabOrder = 5
    TabWidth = 180
    StyleElements = [seBorder]
    OnEnter = PageControlEnter
    object tbsFormula: TTabSheet
      Caption = 'Formula'#231#227'o'
      object pnlSubProdutos: TPanel
        Left = 0
        Top = 0
        Width = 1008
        Height = 80
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 30
          Top = 10
          Width = 65
          Height = 14
          Caption = 'Sub. Produto:'
        end
        object Label3: TLabel
          Left = 583
          Top = 10
          Width = 56
          Height = 14
          Alignment = taRightJustify
          Caption = 'Refer'#234'ncia:'
        end
        object Label4: TLabel
          Left = 779
          Top = 10
          Width = 42
          Height = 14
          Alignment = taRightJustify
          Caption = 'Unidade:'
        end
        object Label6: TLabel
          Left = 41
          Top = 56
          Width = 54
          Height = 14
          Alignment = taRightJustify
          Caption = 'Percentual:'
        end
        object Label7: TLabel
          Left = 68
          Top = 33
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fase:'
        end
        object Label11: TLabel
          Left = 180
          Top = 56
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object Label17: TLabel
          Left = 448
          Top = 33
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sequ'#234'ncia Geral:'
        end
        object Label20: TLabel
          Left = 201
          Top = 56
          Width = 52
          Height = 14
          Alignment = taRightJustify
          Caption = 'Toler'#226'ncia:'
        end
        object Label21: TLabel
          Left = 335
          Top = 56
          Width = 10
          Height = 14
          Alignment = taRightJustify
          Caption = '%'
        end
        object edtDesSubProduto: TEditFocus
          Left = 151
          Top = 6
          Width = 426
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 7
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSubProduto: TEditFocus
          Tag = 99
          Left = 99
          Top = 6
          Width = 51
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtSubProdutoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtSubReferencia: TEditFocus
          Left = 640
          Top = 6
          Width = 131
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSubUnidade: TEditFocus
          Left = 822
          Top = 6
          Width = 41
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          TabOrder = 9
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSubQtdIte: TEditFocus
          Tag = 99
          Left = 99
          Top = 52
          Width = 78
          Height = 22
          Alignment = taRightJustify
          Color = clWhite
          MaxLength = 10
          TabOrder = 3
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 10
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtCodFas: TEditFocus
          Tag = 99
          AlignWithMargins = True
          Left = 99
          Top = 29
          Width = 51
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 3
          TabOrder = 1
          OnKeyPress = edtCodFasKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object edtDesFas: TEditFocus
          Left = 150
          Top = 29
          Width = 292
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
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
        object btnAdicionar: TBitBtnLocked
          Left = 351
          Top = 52
          Width = 111
          Height = 22
          Caption = '&Confirma'
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
          TabOrder = 5
          OnClick = btnAdicionarClick
        end
        object btnCancelaItem: TBitBtnLocked
          Left = 468
          Top = 52
          Width = 111
          Height = 22
          Caption = 'C&ancelar'
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
          TabOrder = 6
          OnClick = btnCancelaItemClick
        end
        object edtSeq: TEditFocus
          Tag = 99
          Left = 536
          Top = 29
          Width = 41
          Height = 22
          Hint = 'N'#227'o Informe a Sequ'#234'ncia para Inserir ao Final da F'#243'rmula'
          Alignment = taRightJustify
          Color = clWhite
          MaxLength = 3
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttInteiro
        end
        object edtPerTol: TEditFocus
          Tag = 99
          Left = 254
          Top = 52
          Width = 78
          Height = 22
          Alignment = taRightJustify
          Color = clWhite
          MaxLength = 10
          TabOrder = 4
          Text = '0,00'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 10
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
      end
      object dbgDados: TDBGridCitel
        Left = 0
        Top = 80
        Width = 1008
        Height = 416
        Align = alClient
        DataSource = dtsConsulta
        ImeName = ' '
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgDadosKeyDown
        CorZebra = clMoneyGreen
        Zebra = True
        DestacarMouse = True
        Columns = <
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DMT_SEQUEN'
            Title.Caption = 'Seq. Geral'
            Width = 59
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DMT_SEQITE'
            Title.Caption = 'Seq. Mat. Prima'
            Width = 83
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DMT_ITESUB'
            Title.Caption = 'Codigo'
            Width = 60
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DMT_DESCRI'
            Title.Caption = 'Descri'#231#227'o'
            Width = 314
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DMT_REFERE'
            Title.Caption = 'Referencia'
            Width = 122
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DMT_QTDITE'
            Title.Alignment = taCenter
            Title.Caption = 'Quantidade'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DMT_PERTOL'
            Title.Caption = '% Toler'#226'ncia'
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DMT_CUSCAL'
            Title.Alignment = taRightJustify
            Title.Caption = 'Custo'
            Width = 69
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DMT_CUS_LT'
            Title.Caption = 'Custo (LT)'
            Visible = False
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'DMT_REPCUS'
            Title.Alignment = taRightJustify
            Title.Caption = '% de repres. custo do produto'
            Width = 160
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'FAS_DESFAS'
            Title.Caption = 'Fase'
            Width = 170
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 0
        Top = 496
        Width = 1008
        Height = 60
        Align = alBottom
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object lblMostraOps: TLabel
          Left = 4
          Top = 40
          Width = 468
          Height = 14
          Caption = 
            'Essa f'#243'rmula n'#227'o pode ser alterada, pois j'#225' possui OPs. Clique a' +
            'qui para saber quais.'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold, fsUnderline]
          ParentFont = False
          Visible = False
          OnClick = lblMostraOpsClick
        end
        object imgEpi: TImage
          Left = 196
          Top = 9
          Width = 22
          Height = 24
          Center = True
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000010
            0000001008060000001FF3FF61000000017352474200AECE1CE9000000046741
            4D410000B18F0BFC61050000001974455874536F6674776172650041646F6265
            20496D616765526561647971C9653C000002E349444154384F6553594F5A6114
            BC7FC25FE17FF0C5C49898F8E4839AF8A2316EB8EF41DCA2B8EFD16850EC834A
            529BD644B1B6A5A8ADD68555E45244105450836DDADA277313A7F3DD566AD387
            E103BE333367CE3D57BABFBF4F401E1D4D76F7F599F6DADB63DBCDCDCADBEA6A
            58EBEA948F5A6D6CBFB3D364D7EB939FD60390123F3C8383DAFD8E8EB8736808
            A1B9395CCFCFE30B11331A71323383BDAE2E6C3636DEEDEBF5FAFF04547267E7
            5DC060C0EDF838AEDBDA70D5D080CB9A1A5CD6D7E3B2B515572323F0F0CEC28E
            6CE3E3C68480776424F9535B5B5C90E37D7D88D5D6E2B2B21217C44F8703E18A
            0A84CBCB71565585F3EE6E3829B45155A5C8EBEBF9AA80A3B7D7641F18407C6C
            2C413E277E6C6EE2E1E101DF7906351A9C1201FE1F66444B6323768686A29148
            2449DA6D6D8D9DD25DB42D5C23C291104421F08D67A0AC0C7EE23311D06AE11C
            1EC62A6B42A1508164A9AD55A21C9AC8FA483E63CB5FCD6655E0766D4D250AC8
            A5A590F9644EA6A6B098958540206092CC25258873DA115E88AC2142B47BB3B4
            A40A5C2F2EC247B297E463D67A781766C786B434F8FDFEA0B4A1D12817B3B308
            D7D525B29EFC717C743D263C241F0901C6F44D4CE0596626645956A477353531
            797212E196967FB25ED15974105D585089EEE262B888E3A626ECF5F4E0797E3E
            3C1E4F50E2C699B6753A9C73307EE67F74BD595DFD1D81A7203A8B8AE014E2FD
            FD78C5EF6F28E276BB4DD28E4E976CD668EEEC83830871DB64CE406415AE67EC
            4C901D243828EAEDE8C0169FD6626E2E6C562B1C0E4781BA895B3A9D7EB5A444
            39E0229D72277CCDCD6A56171D5D3C3D7CEE3E3AABE4EC6C58B9DA24AFD86CB6
            A4C4BBF0A1B7D7F8B2B050319370C06299833A65E131D777971BC83B2CE4E4E0
            FDF434EC76FB01C9A9FFBC4C02F6E5E57C4B5757F4058B8D1919984C4981213D
            1D4B797978CD78FB160B485C393C3C4C15F5AA80F8780A9FCF97E4F57A0B3861
            D3D1D151D0E572296C37485713C9052427FDAD87F40BA328D260309B7A0C0000
            000049454E44AE426082}
          Visible = False
        end
        object lblMsgEpi: TLabel
          Left = 225
          Top = 15
          Width = 240
          Height = 14
          Caption = 'Nenhum EPI selecionado para essa F'#243'rmula'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Visible = False
        end
        object pnlTotais: TPanel
          Left = 476
          Top = 1
          Width = 531
          Height = 58
          Align = alRight
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object pnlPesos: TPanel
            Left = 376
            Top = 0
            Width = 155
            Height = 58
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
            DesignSize = (
              155
              58)
            object Label16: TLabel
              Left = 76
              Top = 7
              Width = 74
              Height = 14
              Alignment = taCenter
              Anchors = [akRight]
              AutoSize = False
              Caption = 'PE REAL'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 80
            end
            object Label14: TLabel
              Left = 1
              Top = 5
              Width = 74
              Height = 14
              Alignment = taCenter
              Anchors = [akRight]
              AutoSize = False
              Caption = 'PE'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 0
            end
            object edtPesRea: TEditFocus
              Tag = 99
              Left = 76
              Top = 27
              Width = 74
              Height = 22
              Alignment = taRightJustify
              Anchors = [akRight]
              Color = clWhite
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              MaxLength = 10
              ParentFont = False
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 10
              TipoTexto = ttNumerico
              EditFormat = '#,##0.0000'
            end
            object edtTotPes: TEditFocus
              Left = 1
              Top = 27
              Width = 74
              Height = 22
              TabStop = False
              Alignment = taCenter
              Anchors = [akRight]
              Color = 16768952
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 1
              Text = 'edtTotPes'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
          end
          object pnlCusKG: TPanel
            Left = 274
            Top = 0
            Width = 102
            Height = 58
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            DesignSize = (
              102
              58)
            object lblTotCusKG: TLabel
              Left = 2
              Top = 7
              Width = 99
              Height = 14
              Alignment = taCenter
              Anchors = [akRight]
              AutoSize = False
              Caption = 'Total Custo'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 0
            end
            object edtTotCus: TEditFocus
              Left = 2
              Top = 27
              Width = 99
              Height = 22
              TabStop = False
              Alignment = taCenter
              Anchors = [akRight]
              Color = 16768952
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              Text = 'edtTotCus'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
          end
          object pnlCusLT: TPanel
            Left = 173
            Top = 0
            Width = 101
            Height = 58
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 2
            DesignSize = (
              101
              58)
            object Label25: TLabel
              Left = 2
              Top = 7
              Width = 99
              Height = 14
              Alignment = taCenter
              Anchors = [akRight]
              AutoSize = False
              Caption = 'Total Custo (LT)'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object edtTotCusLT: TEditFocus
              Left = 2
              Top = 27
              Width = 99
              Height = 22
              TabStop = False
              Alignment = taCenter
              Anchors = [akRight]
              Color = 16768952
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              Text = 'edtTotCus'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
          end
          object pnlPercentualTotal: TPanel
            Left = 98
            Top = 0
            Width = 75
            Height = 58
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 3
            DesignSize = (
              75
              58)
            object Label12: TLabel
              Left = 1
              Top = 7
              Width = 74
              Height = 14
              Alignment = taCenter
              Anchors = [akRight]
              AutoSize = False
              Caption = '% Total'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              ExplicitLeft = 9
            end
            object edtTotPer: TEditFocus
              Left = 1
              Top = 27
              Width = 74
              Height = 22
              TabStop = False
              Alignment = taCenter
              Anchors = [akRight]
              Color = 16768952
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
              ReadOnly = True
              TabOrder = 0
              Text = 'edtTotPer'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
          end
        end
        object btnEpi: TBitBtnLocked
          Left = 4
          Top = 2
          Width = 186
          Height = 35
          Caption = '[F11] Configura'#231#227'o de EPI'#39's'
          Enabled = False
          Glyph.Data = {
            B6080000424DB608000000000000360400002800000030000000180000000100
            08000000000080040000130F0000130F00000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
            A6000020400000206000002080000020A0000020C0000020E000004000000040
            20000040400000406000004080000040A0000040C0000040E000006000000060
            20000060400000606000006080000060A0000060C0000060E000008000000080
            20000080400000806000008080000080A0000080C0000080E00000A0000000A0
            200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
            200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
            200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
            20004000400040006000400080004000A0004000C0004000E000402000004020
            20004020400040206000402080004020A0004020C0004020E000404000004040
            20004040400040406000404080004040A0004040C0004040E000406000004060
            20004060400040606000406080004060A0004060C0004060E000408000004080
            20004080400040806000408080004080A0004080C0004080E00040A0000040A0
            200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
            200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
            200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
            20008000400080006000800080008000A0008000C0008000E000802000008020
            20008020400080206000802080008020A0008020C0008020E000804000008040
            20008040400080406000804080008040A0008040C0008040E000806000008060
            20008060400080606000806080008060A0008060C0008060E000808000008080
            20008080400080806000808080008080A0008080C0008080E00080A0000080A0
            200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
            200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
            200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
            2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
            2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
            2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
            2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
            2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
            2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
            2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDFDFDFDFDFD
            FDFDFDFDA4A4A4FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD9B9B9BFD
            FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDA4A3E3D991FDFDFDFDFDFDFDFD
            FDFDFDFDFDFDFDFDFDFDFD9BA4A49B52FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
            FDFDFD9BA3EBE1D9FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD9BA4F7A49B
            FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD9BA3EBE1D9FDFDFDFDFDFDFDFD
            FDFDFDFDFDFDFDFDFDFDFD9BA4F7A49BFDFDFDFDFDFDFDFDFDFDFDFDFD5B5B5B
            5BFDFD9BA3EBE199FDFDFDFDFDFDFDFDFDFDFDFDFD5B5B5B5BFDFD9BA4F7A45B
            FDFDFDFDFDFDFDFDFDFDFDFDA4F7F7F7A45BFD9BE4EAE19AFDFDFDFDFDFDFDFD
            FDFDFDFDA4F7F7F7A45BFD9BA4F7A45BFDFDFDFDFDFDFDFDFDFDFDA407070707
            07F75B9BE4EAE19AFDFDFDFDFDFDFDFDFDFDFDA40707070707F75B9BA4F7A45B
            FDFDFDFDFDFDFDFDFDFDFDA4A4A4A4EE0707079BEBE2E19A5B5B5B5B5B5B5B9B
            FDFDFDA4A4A4A4070707079BF7A4A49B5B5B5B5B5B5B5B9BFDFDFDFDFDFDFD9B
            0707F79BEBE2E19AA4F7F7F7F7F7F7A45BFDFDFDFDFDFD9B0707F79BF7A4A45B
            A4F7F7F7F7F7F7A45BFDFDFDFDFDFD9B0707F79BEBE2E192F707F707F707F7F7
            5BFDFDFDFDFDFD9B0707F79BF7A4A45BF707F707F707F7F75BFDFDF79B9B9B07
            070707A3EBE2E192A4A4A4A4A4A4A4A4FDFDFDF79B9B9B070707079BF7A4A45B
            A4A4A4A4A4A4A4A4FDFDFDF70808080707F75B9BECE1E192FDFDFDFDFDFDFDFD
            FDFDFDF70808080707F75B9BF7A4A45BFDFDFDFDFDFDFDFDFDFDFDFDF7F70707
            F7A4FD9BECE1E29AFDFDFDFDFDFDFDFDFDFDFDFDF7F70707F7A4FD5BF7A4A49B
            FDFDFDFDFDFDFDFDFDFDFDFDFDF7F7A4A4FDFDA309E1E29BFDFDFDFDFDFDFDFD
            FDFDFDFDFDF7F7A4A4FDFDA407A4A49BFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
            FDFDFD9B09E1E29BFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD9B07A4A4A4
            FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD9AE39ADA9BFDFDFDFDFDFDFDFD
            FDFDFDFDFDFDFDFDFDFDFD5BA45BA4A4FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD
            FDFDFD5BF7F79B5BFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFDFD5BF7F79B5B
            FDFDFDFDFDFDFDFDFDFDFDFDFDFDFDA45BFDFD5BA49B5B5BFDFDFDFDFDFDFDFD
            FDFDFDFDFDFDFDA45BFDFD5BA49B5B5BFDFDFDFDFDFDFDFDFDFDFDFDFDFDA4F6
            EDE45B5BF707075BFDFDFDFDFDFDFDFDFDFDFDFDFDFDA4F607F75B5BF707075B
            FDFDFDFDFDFDFDFDFDFDFDFDFD6408089BF7A45BF70707075BFDFDFD5BA4FDFD
            FDFDFDFDFD9B08089BF7A45BF70707075BFDFDFD5B9BFDFDFDFDFDFDFD9B0707
            9B07F79BA4070707075B5B5B5BA4FDFDFDFDFDFDFD9B07079B07F79BA4070707
            075B5B5B5B9BFDFDFDFDFDFDFD6407079BF6F79BF7F7F70707070707F7A4FDFD
            FDFDFDFDFD9B07079BF6F79BF7F7F70707070707F79BFDFDFDFDFDFDFD9B079B
            F7A49BF70807070707F7F7A4A4FDFDFDFDFDFDFDFD9B079BF7A49BF708070707
            07F7F79B9BFDFDFDFDFDFDFDFDFD9B9BA407A4A4A4A4A4A4A4A45BFDFDFDFDFD
            FDFDFDFDFDFD9B9BA407A4A4A4A4A4A4A4A49BFDFDFDFDFDFDFD}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = btnEpiClick
        end
      end
    end
    object tbsAnalise: TTabSheet
      Caption = 'An'#225'lise'
      ImageIndex = 1
      OnShow = tbsAnaliseShow
      object pnlAnalises: TPanel
        Left = 0
        Top = 0
        Width = 1008
        Height = 64
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label22: TLabel
          Left = 24
          Top = 12
          Width = 39
          Height = 14
          Caption = 'An'#225'lise:'
        end
        object edtCodAna: TEditFocus
          Tag = 99
          Left = 67
          Top = 8
          Width = 51
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 5
          TabOrder = 0
          OnKeyPress = edtCodAnaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesAna: TEditFocus
          Left = 119
          Top = 8
          Width = 591
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
        object btnConfirmaAnalise: TBitBtnLocked
          Left = 484
          Top = 36
          Width = 111
          Height = 22
          Caption = '&Confirma'
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
          TabOrder = 3
          OnClick = btnConfirmaAnaliseClick
        end
        object btnCancelaAnalise: TBitBtnLocked
          Left = 599
          Top = 36
          Width = 111
          Height = 22
          Caption = 'C&ancelar'
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
          TabOrder = 4
          OnClick = btnCancelaAnaliseClick
        end
        object pgcResultadoAnalise: TPageControl
          Tag = 99
          Left = 2
          Top = 30
          Width = 475
          Height = 33
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          ParentCustomHint = False
          ActivePage = tbsIntervaloValores
          Style = tsFlatButtons
          TabOrder = 2
          StyleElements = []
          OnEnter = pgcResultadoAnaliseEnter
          object tbsIntervaloValores: TTabSheet
            Caption = 'tbsIntervaloValores'
            TabVisible = False
            object Label23: TLabel
              Left = 17
              Top = 4
              Width = 35
              Height = 14
              Alignment = taRightJustify
              Caption = 'M'#237'nimo:'
            end
            object Label24: TLabel
              Left = 183
              Top = 4
              Width = 39
              Height = 14
              Alignment = taRightJustify
              Caption = 'M'#225'ximo:'
            end
            object Label26: TLabel
              Left = 344
              Top = -3
              Width = 113
              Height = 31
              AutoSize = False
              Caption = '*pgcResultadoAnalise Intervalo / Descri'#231#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clRed
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
              Visible = False
              WordWrap = True
            end
            object edtAnaMin: TEditFocus
              Tag = 99
              Left = 55
              Top = 0
              Width = 106
              Height = 22
              Alignment = taRightJustify
              Color = clWhite
              MaxLength = 10
              TabOrder = 0
              Text = '0,00'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 10
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtAnaMax: TEditFocus
              Tag = 99
              Left = 223
              Top = 0
              Width = 106
              Height = 22
              Alignment = taRightJustify
              Color = clWhite
              MaxLength = 10
              TabOrder = 1
              Text = '0,00'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 10
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
          end
          object tbsDescricaoAberta: TTabSheet
            Caption = 'tbsDescricaoAberta'
            ImageIndex = 1
            TabVisible = False
            object Label13: TLabel
              Left = 0
              Top = 4
              Width = 52
              Height = 14
              Alignment = taRightJustify
              Caption = 'Descri'#231#227'o:'
            end
            object edtDescricaoResultadoAnalise: TEditFocus
              Tag = 99
              Left = 55
              Top = 0
              Width = 410
              Height = 22
              Alignment = taLeftJustify
              MaxLength = 50
              TabOrder = 0
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
        object ChkComponenteAB: TCheckBox
          Left = 739
          Top = 11
          Width = 122
          Height = 17
          TabStop = False
          Caption = ' Componente A + B'
          TabOrder = 5
          Visible = False
        end
      end
      object dbgAnalise: TDBGridCitel
        Left = 0
        Top = 64
        Width = 1008
        Height = 492
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDblClick = dbgAnaliseDblClick
        OnKeyDown = dbgAnaliseKeyDown
        CorZebra = clMoneyGreen
        Zebra = True
        DestacarMouse = True
        Columns = <
          item
            Expanded = False
            FieldName = 'GAN_CODANA'
            Title.Caption = 'C'#243'digo'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ANA_DESCRI'
            Title.Caption = 'Descri'#231#227'o'
            Width = 365
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RESULTADOESPERADO'
            Title.Caption = 'Resultado Esperado'
            Width = 393
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'GAN_INFOAB'
            Title.Caption = 'Componente'
            Visible = False
          end>
      end
    end
    object TbsDescProcedimentoProd: TTabSheet
      Caption = 'Descri'#231#227'o Procedimento Produ'#231#227'o'
      ImageIndex = 2
      object RichDescProcProducao: TRichEdit
        Left = 0
        Top = 0
        Width = 1008
        Height = 556
        Align = alClient
        TabOrder = 0
        Zoom = 100
      end
    end
    object tbsExtrusao: TTabSheet
      Caption = 'Proc. Extrus'#227'o'
      ImageIndex = 3
      object pnlOperador: TPanel
        Left = 0
        Top = 0
        Width = 1008
        Height = 101
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label27: TLabel
          Left = 11
          Top = 21
          Width = 49
          Height = 14
          Caption = 'Operador:'
        end
        object Label28: TLabel
          Left = 11
          Top = 47
          Width = 88
          Height = 14
          Caption = 'Inicio da Extrus'#227'o:'
        end
        object Label29: TLabel
          Left = 11
          Top = 71
          Width = 118
          Height = 14
          Caption = 'Finaliza'#231#227'o da Extrus'#227'o:'
        end
        object EdtOpeNomeExtrusao: TEditFocus
          Left = 112
          Top = 13
          Width = 541
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
        object EdCodOpeExtrusao: TEditFocus
          Tag = 99
          Left = 65
          Top = 13
          Width = 43
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = EdCodOpeExtrusaoExit
          OnKeyPress = EdCodOpeExtrusaoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object MskHraFinalExtrusao: TMaskEditFocus
          Tag = 99
          Left = 133
          Top = 68
          Width = 118
          Height = 22
          EditMask = '!99:99;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 3
          Text = '  :  '
          OnKeyPress = MskHraFinalExtrusaoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object MskHraInicioExtrusao: TMaskEditFocus
          Tag = 99
          Left = 133
          Top = 41
          Width = 119
          Height = 22
          EditMask = '!99:99;1;_'
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          TabOrder = 2
          Text = '  :  '
          OnExit = MskHraInicioExtrusaoExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 101
        Width = 1008
        Height = 136
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object cxgExtrusao: TcxGridCitel
          Tag = 99
          Left = 1
          Top = 1
          Width = 1006
          Height = 134
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object cxvExtrusao: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            OnEditKeyDown = cxvExtrusaoEditKeyDown
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracImmediately
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.Appending = True
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsSelection.HideFocusRectOnExit = False
            OptionsSelection.UnselectFocusedRecordOnExit = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object cxvExtrusaoTermostato: TcxGridDBColumn
              Caption = 'Termostato'
              DataBinding.FieldName = 'NOMTER'
              Options.Editing = False
              Width = 300
            end
            object cxvExtrusao01: TcxGridDBColumn
              Caption = #186' C Extrussoura 01'
              DataBinding.FieldName = 'EXTS01'
              Width = 200
            end
            object cxvExtrusao02: TcxGridDBColumn
              Caption = #186' C Extrussoura 02'
              DataBinding.FieldName = 'EXTS02'
              Width = 200
            end
            object cxvExtrusao03: TcxGridDBColumn
              Caption = #186' C Extrussoura 03'
              DataBinding.FieldName = 'EXTS03'
              Width = 200
            end
          end
          object cxgExtrusaoLevel1: TcxGridLevel
            GridView = cxvExtrusao
          end
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 237
        Width = 1008
        Height = 60
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 2
        object Label30: TLabel
          Left = 11
          Top = 13
          Width = 147
          Height = 14
          Caption = 'Velocidade Rota'#231#227'o da Roska:'
        end
        object Label31: TLabel
          Left = 11
          Top = 41
          Width = 119
          Height = 14
          Caption = 'Velocidade do Picotador:'
        end
        object edtRotacaoRoska: TEditFocus
          Tag = 99
          Left = 161
          Top = 5
          Width = 104
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 0
          OnExit = edtRotacaoRoskaExit
          OnKeyPress = edtRotacaoRoskaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
        object edtPicotador: TEditFocus
          Tag = 99
          Left = 161
          Top = 33
          Width = 104
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 1
          OnExit = edtPicotadorExit
          OnKeyPress = edtPicotadorKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
        end
      end
      object Panel4: TPanel
        Left = 0
        Top = 297
        Width = 1008
        Height = 101
        Align = alTop
        BevelInner = bvLowered
        BevelOuter = bvNone
        Color = 16770261
        ParentBackground = False
        TabOrder = 3
        object Label32: TLabel
          Left = 11
          Top = 11
          Width = 59
          Height = 14
          Caption = 'Obseva'#231#227'o:'
        end
        object RichObservacaoExtrusao: TRichEdit
          Tag = 99
          Left = 1
          Top = 1
          Width = 1006
          Height = 99
          Align = alClient
          TabOrder = 0
          Zoom = 100
        end
      end
    end
    object tbsFases: TTabSheet
      Caption = 'Fases'
      ImageIndex = 4
      TabVisible = False
      object dbgGfaFases: TcxGridCitel
        Tag = 99
        Left = 0
        Top = 41
        Width = 1008
        Height = 515
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object dbgGfaFasesView: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyDown = dbgGfaFasesViewEditKeyDown
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracImmediately
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.HideFocusRectOnExit = False
          OptionsSelection.UnselectFocusedRecordOnExit = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridSeq: TcxGridDBColumn
            Caption = 'Seq. Geral'
            DataBinding.FieldName = 'GFA_SEQUEC'
            Options.Editing = False
            Width = 80
          end
          object cxGridCod: TcxGridDBColumn
            Caption = 'Fase'
            DataBinding.FieldName = 'CODFAS'
            Width = 100
          end
          object cxGridFase: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESFAS'
            Width = 250
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = dbgGfaFasesView
        end
      end
      object pnlFasesEspecial: TPanel
        Left = 0
        Top = 0
        Width = 1008
        Height = 41
        Align = alTop
        Color = 16770261
        Enabled = False
        ParentBackground = False
        TabOrder = 1
        object Label37: TLabel
          Left = 68
          Top = 10
          Width = 27
          Height = 14
          Alignment = taRightJustify
          Caption = 'Fase:'
        end
        object Label39: TLabel
          Left = 448
          Top = 10
          Width = 83
          Height = 14
          Alignment = taRightJustify
          Caption = 'Sequ'#234'ncia Geral:'
        end
        object EdtCodFaseEspecial: TEditFocus
          Tag = 99
          Left = 99
          Top = 6
          Width = 51
          Height = 22
          Alignment = taLeftJustify
          MaxLength = 3
          TabOrder = 0
          OnKeyPress = EdtCodFaseEspecialKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttAlfanumerico
        end
        object EdtDesFaseEspecial: TEditFocus
          Left = 150
          Top = 6
          Width = 292
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnConfirmaFaseEspecial: TBitBtnLocked
          Left = 583
          Top = 5
          Width = 111
          Height = 22
          Caption = '&Confirma'
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
          OnClick = btnConfirmaFaseEspecialClick
        end
        object btnCancelaFaseEspecial: TBitBtnLocked
          Left = 700
          Top = 5
          Width = 111
          Height = 22
          Caption = 'C&ancelar'
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
          TabOrder = 3
          OnClick = btnCancelaFaseEspecialClick
        end
        object EdtSeqFaseEspecial: TEditFocus
          Tag = 99
          Left = 537
          Top = 5
          Width = 41
          Height = 22
          Hint = 'N'#227'o Informe a Sequ'#234'ncia para Inserir ao Final da F'#243'rmula'
          Alignment = taRightJustify
          Color = clWhite
          MaxLength = 3
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 3
          TipoTexto = ttInteiro
        end
      end
    end
  end
  object pnlCapacidadeMaxima: TPanel [5]
    Left = 0
    Top = 109
    Width = 1016
    Height = 33
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object lblCapacidadeMaxima: TLabel
      Left = 30
      Top = 9
      Width = 187
      Height = 14
      Alignment = taRightJustify
      Caption = 'Capacidade M'#225'xima de Produ'#231#227'o (Kg):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtCapacidadeMaxima: TEditFocus
      Tag = 99
      Left = 223
      Top = 6
      Width = 113
      Height = 22
      Alignment = taRightJustify
      Color = clWhite
      MaxLength = 10
      TabOrder = 0
      Text = '0,000'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 10
      TipoTexto = ttNumerico
      EditFormat = '#,###0.000'
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 824
    Top = 128
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 520
    Top = 440
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 472
    Top = 360
  end
  object frxPaginaM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40456.592838541670000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 39 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    DMPMemo8.Height    := 16;'
      '    DMPMemo6.Height    := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    DMPMemo9.Height    := 16;          '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    DMPMemo8.Height    := 33;'
      '    DMPMemo6.Height    := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    DMPMemo9.Height    := 33;        '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    DMPMemo8.Height    := 50;'
      '    DMPMemo6.Height    := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    DMPMemo9.Height := 50;'
      '  End;'
      ''
      '  fAbreFormulaSubItensRel(<frxRelatorio."DMT_ITESUB">);  '
      '    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaJUserFunction
    Left = 152
    Top = 376
    Datasets = <
      item
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 241.299844160517300000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 892.800000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 547.200000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 221.000000000000000000
        Width = 892.800000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
        object DMPMemo6: TfrxDMPMemoView
          Left = 547.200000000000000000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIte: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 364.800000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 153.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValIte: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValTot: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 892.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 57.600000000000000000
          Top = 17.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 28.800000000000000000
          Top = 68.000000000000000000
          Width = 844.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#18#27#77'
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 892.800000000000000000
        object rdbSumTot: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 892.800000000000000000
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
        RowCount = 0
        object DMPMemo7: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFormIte."DMT_QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIteDet: TfrxDMPMemoView
          Left = 38.400000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 412.800000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxRelatorio: TfrxDBDataset
    UserName = 'frxRelatorio'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 304
    Top = 320
  end
  object qryConsulta: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Constraints = <>
    Left = 152
    Top = 328
  end
  object dspConsulta: TUniDataSetProvider
    DataSet = qryConsulta
    Options = []
    Left = 184
    Top = 328
  end
  object cdsConsulta: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    ProviderName = 'dspConsulta'
    AfterScroll = cdsConsultaAfterScroll
    Left = 216
    Top = 328
  end
  object dtsConsulta: TDataSource
    DataSet = cdsConsulta
    Left = 248
    Top = 328
  end
  object frxSemPrecoM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 40456.595127129630000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 50 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;      '
      '    DMPMemo6.Height    := 16;'
      '    DMPMemo8.Height    := 16;'
      '    DMPMemo9.Height    := 16;        '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 50 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    DMPMemo6.Height    := 33;'
      '    DMPMemo8.Height    := 33;'
      '    DMPMemo9.Height    := 33;        '
      '  End;'
      ''
      '  fAbreFormulaSubItensRel(<frxRelatorio."DMT_ITESUB">);  '
      '    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaJUserFunction
    Left = 160
    Top = 424
    Datasets = <
      item
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      PaperWidth = 241.299844160517300000
      PaperHeight = 296.862308276425900000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 221.000000000000000000
        Width = 892.800000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
        object DMPMemo6: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIte: TfrxDMPMemoView
          Left = 76.800000000000000000
          Width = 518.400000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 604.800000000000000000
          Width = 201.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 816.000000000000000000
          Width = 67.200000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 892.800000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 76.800000000000000000
          Top = 17.000000000000000000
          Width = 518.400000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 604.800000000000000000
          Top = 17.000000000000000000
          Width = 201.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 816.000000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 892.800000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 57.600000000000000000
          Top = 17.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 201.600000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 758.400000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 28.800000000000000000
          Top = 68.000000000000000000
          Width = 844.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#18#27#77'
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 892.800000000000000000
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
        RowCount = 0
        object DMPMemo7: TfrxDMPMemoView
          Left = 28.800000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFormIte."DMT_QTDITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIteDet: TfrxDMPMemoView
          Left = 96.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 470.400000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxSemPrecoJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 45637.594732002310000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 50 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;      '
      '    Memo6.Height       := 16;'
      '    Memo8.Height       := 16;'
      '    Shape2.Height      := 16;          '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 50 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    Memo6.Height       := 33;'
      '    Memo8.Height       := 33;'
      '    Shape2.Height      := 33;        '
      '  End;'
      ''
      '  fAbreFormulaSubItensRel(<frxRelatorio."DMT_ITESUB">);  '
      '    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaJUserFunction
    Left = 208
    Top = 424
    Datasets = <
      item
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 241.299844160000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 42.330723310000000000
        Top = 204.094620000000000000
        Width = 836.409399998044800000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
        object Shape2: TfrxShapeView
          Left = 1.889763780000000000
          Width = 831.496600000000000000
          Height = 37.795285350000000000
        end
        object Memo6: TfrxMemoView
          Left = 3.779530000000000000
          Top = 0.559060000000000000
          Width = 51.779530000000000000
          Height = 34.015757800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbDesIte: TfrxMemoView
          Left = 60.379530000000000000
          Top = 0.559060000000000000
          Width = 468.056710000000000000
          Height = 34.015757800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 530.579530000000000000
          Top = 0.559060000000000000
          Width = 210.141707870000000000
          Height = 34.015757800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 158.740260000000000000
        Width = 836.409399998044800000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Top = 1.779529999999994000
          Width = 831.496600000000000000
          Height = 18.897635350000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 3.779530000000000000
          Top = 1.779530000000000000
          Width = 51.779530000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 60.379530000000000000
          Top = 1.779530000000000000
          Width = 468.056710000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 530.579530000000000000
          Top = 1.779530000000000000
          Width = 210.141707870000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 744.379530000000000000
          Top = 1.779530000000000000
          Width = 84.661410000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 79.322819999999990000
        Top = 18.897650000000000000
        Width = 836.409399998044800000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 29.404699999022400000
          Top = 3.661410000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 173.404699999022400000
          Top = 27.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 701.707050000000000000
          Top = 27.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 18.481879999022550000
          Top = 55.000000000000000000
          Width = 799.445639999999700000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object detDetalhe: TfrxDetailData
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 268.346630000000000000
        Visible = False
        Width = 836.409399998044800000
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
        RowCount = 0
        object rdbDesIteDet: TfrxMemoView
          Left = 27.056514720000000000
          Top = 0.755905510000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."ITE_DESITE"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 374.579407950000000000
          Top = 0.755905510000000000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."FAS_DESFAS"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 532.913730000000000000
          Top = 0.755905510000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFormIte."DMT_QTDITE"]')
          ParentFont = False
        end
      end
    end
  end
  object frxPreCusM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42927.709497037040000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 39 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    DMPMemo8.Height    := 16;'
      '    DMPMemo6.Height    := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    rdbValMed.Height   := 16;'
      '    rdbUltCom.Height   := 16;'
      '    DMPMemo9.Height    := 16;          '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    DMPMemo8.Height    := 33;'
      '    DMPMemo6.Height    := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    rdbValMed.Height   := 33;'
      '    rdbUltCom.Height   := 33;'
      '    DMPMemo9.Height    := 33;        '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    DMPMemo8.Height    := 50;'
      '    DMPMemo6.Height    := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    rdbValMed.Height   := 50;'
      '    rdbUltCom.Height   := 50;'
      '    DMPMemo9.Height    := 50;        '
      '  End;'
      ''
      '  fAbreFormulaSubItensRel(<frxRelatorio."DMT_ITESUB">);  '
      '    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaJUserFunction
    Left = 220
    Top = 472
    Datasets = <
      item
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 297.179808071374000000
      PaperHeight = 242.887343135257600000
      PaperSize = 256
      LeftMargin = 2.539998359584393000
      RightMargin = 2.539998359584393000
      TopMargin = 4.497913761764029000
      BottomMargin = 4.497913761764029000
      ColumnWidth = 2.539998359584393000
      FontStyle = [fsx12cpi]
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 1104.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 384.000000000000000000
          Top = 17.000000000000000000
          Width = 144.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 614.400000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 720.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. MEDIO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'ULT COMPRA')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 221.000000000000000000
        Width = 1104.000000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
        object DMPMemo6: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 67.200000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIte: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 364.800000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 384.000000000000000000
          Width = 144.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValIte: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValTot: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValMed: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREMED"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbUltCom: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DTAULT"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 1104.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 307.200000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 124.800000000000000000
          Top = 68.000000000000000000
          Width = 844.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#18#27#77'
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1104.000000000000000000
        object rdbSumTot: TfrxDMPMemoView
          Left = 720.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 614.400000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 1104.000000000000000000
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
        RowCount = 0
        object DMPMemo14: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFormIte."DMT_QTDITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIteDet: TfrxDMPMemoView
          Left = 38.400000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo16: TfrxDMPMemoView
          Left = 412.800000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPreCusJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42927.709299606480000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin          '
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 39 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    Memo8.Height       := 16;'
      '    Memo6.Height       := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    Memo7.Height       := 16;'
      '    Memo15.Height      := 16;'
      '    Memo13.Height      := 16;'
      '    Shape2.Height      := 16;          '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    Memo8.Height       := 33;'
      '    Memo6.Height       := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    Memo7.Height       := 33;'
      '    Memo15.Height      := 33;'
      '    Memo13.Height      := 33;'
      '    Shape2.Height      := 33;        '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 78 Then     ' +
        '                      '
      '  Begin              '
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    Memo8.Height       := 50;'
      '    Memo6.Height       := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    Memo7.Height       := 50;'
      '    Memo15.Height      := 50;'
      '    Memo13.Height      := 50;'
      '    Shape2.Height      := 50;        '
      '  End;'
      ''
      '  fAbreFormulaSubItensRel(<frxRelatorio."DMT_ITESUB">);      '
      '    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaJUserFunction
    Left = 155
    Top = 473
    Datasets = <
      item
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 296.900000000000000000
      PaperHeight = 241.300000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 53.669313310000000000
        Top = 204.094620000000000000
        Width = 1046.551857000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintIfDetailEmpty = True
        RowCount = 0
        object Shape2: TfrxShapeView
          Left = 1.889763780000000000
          Width = 1039.370750000000000000
          Height = 49.133875350000000000
        end
        object Memo6: TfrxMemoView
          Left = 539.779530000000000000
          Top = 0.559060000000000000
          Width = 51.779530000000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbDesIte: TfrxMemoView
          Left = 1.852010000000000000
          Top = 0.559060000000000000
          Width = 366.614214720000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 371.579530000000000000
          Top = 0.559060000000000000
          Width = 166.299197950000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbValIte: TfrxMemoView
          Left = 593.811380000000000000
          Width = 86.929133860000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rdbValTot: TfrxMemoView
          Left = 683.520100000000000000
          Width = 90.708663860000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 981.286580000000000000
          Width = 54.425170000000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 776.787880000000000000
          Width = 98.267723860000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREMED"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 878.394250000000000000
          Width = 98.267723860000000000
          Height = 45.354347800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DTAULT"]')
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 158.740260000000000000
        Width = 1046.551857000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Top = 1.779529999999994000
          Width = 1039.370750000000000000
          Height = 18.897635350000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 539.779530000000000000
          Top = 1.779529999999994000
          Width = 51.779530000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 2.379530000000000000
          Top = 1.779529999999994000
          Width = 366.614214720000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 371.579530000000000000
          Top = 1.779529999999994000
          Width = 166.299197950000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 980.286580000000000000
          Top = 1.779529999999994000
          Width = 58.204700000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 593.811380000000000000
          Top = 1.779529999999994000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. ITEM')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 683.520100000000000000
          Top = 1.779529999999994000
          Width = 90.708663860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 776.787880000000000000
          Top = 1.779529999999994000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. MEDIO')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 878.394250000000000000
          Top = 1.779529999999994000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'ULT COMPRA')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 79.322820000000000000
        Top = 18.897650000000000000
        Width = 1046.551857000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 134.475928500000000000
          Top = 3.661410000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 278.475928500000000000
          Top = 27.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 914.707050000000000000
          Top = 27.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 123.553108500000000000
          Top = 55.000000000000000000
          Width = 799.445640000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 321.260050000000000000
        Width = 1046.551857000000000000
        object rdbSumTot: TfrxMemoView
          Left = 683.520100000000000000
          Width = 90.708663860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 592.811380000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
      end
      object detDetalhe: TfrxDetailData
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 279.685220000000000000
        Visible = False
        Width = 1046.551857000000000000
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
        RowCount = 0
        object rdbDesIteDet: TfrxMemoView
          Left = 27.056514720000000000
          Top = 0.755905510000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."ITE_DESITE"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 374.579407950000000000
          Top = 0.755905510000000000
          Width = 162.519790000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."FAS_DESFAS"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 534.866110000000000000
          Top = 0.755905510000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFormIte."DMT_QTDITE"]')
          ParentFont = False
        end
      end
    end
  end
  object frxPreCusLitroM: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42927.709497037000000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;'
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 39 Then'
      '  Begin'
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    DMPMemo8.Height    := 16;'
      '    DMPMemo6.Height    := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    rdbValMed.Height   := 16;'
      '    rdbUltCom.Height   := 16;'
      '    DMPMemo9.Height    := 16;'
      '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 78 Then'
      '  Begin'
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    DMPMemo8.Height    := 33;'
      '    DMPMemo6.Height    := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    rdbValMed.Height   := 33;'
      '    rdbUltCom.Height   := 33;'
      '    DMPMemo9.Height    := 33;'
      '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 78 Then'
      '  Begin'
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    DMPMemo8.Height    := 50;'
      '    DMPMemo6.Height    := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    rdbValMed.Height   := 50;'
      '    rdbUltCom.Height   := 50;'
      '    DMPMemo9.Height    := 50;'
      '  End;'
      ''
      '  fAbreFormulaSubItensRel(<frxRelatorio."DMT_ITESUB">);  '
      '    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaJUserFunction
    Left = 154
    Top = 520
    Datasets = <
      item
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxDMPPage
      Orientation = poLandscape
      PaperWidth = 297.179808071374000000
      PaperHeight = 242.887343135257600000
      PaperSize = 256
      LeftMargin = 2.539998359584390000
      RightMargin = 2.539998359584390000
      TopMargin = 4.497913761764030000
      BottomMargin = 4.497913761764030000
      ColumnWidth = 2.539998359584390000
      FontStyle = [fsx12cpi]
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 51.000000000000000000
        Top = 153.000000000000000000
        Width = 1104.000000000000000000
        ReprintOnNewPage = True
        object DMPMemo2: TfrxDMPMemoView
          Left = 355.200000000000000000
          Top = 17.000000000000000000
          Width = 67.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo3: TfrxDMPMemoView
          Left = 9.600000000000000000
          Top = 17.000000000000000000
          Width = 211.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo4: TfrxDMPMemoView
          Left = 230.400000000000000000
          Top = 17.000000000000000000
          Width = 115.200000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo5: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Top = 17.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo10: TfrxDMPMemoView
          Left = 432.000000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. ITEM')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo11: TfrxDMPMemoView
          Left = 537.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL(KG)')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo7: TfrxDMPMemoView
          Left = 825.600000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. MEDIO')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo12: TfrxDMPMemoView
          Left = 931.200000000000000000
          Top = 17.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'ULT COMPRA')
          ParentFont = False
          TruncOutboundText = False
        end
        object DMPMemo14: TfrxDMPMemoView
          Left = 681.600000000000000000
          Top = 17.000000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          FontStyle = [fsxBold, fsx12cpi]
          Frame.Typ = [ftLeft, ftTop, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL(LT)')
          ParentFont = False
          TruncOutboundText = False
        end
      end
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 68.000000000000000000
        Top = 221.000000000000000000
        Width = 1104.000000000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
        object DMPMemo6: TfrxDMPMemoView
          Left = 355.200000000000000000
          Width = 67.200000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIte: TfrxDMPMemoView
          Left = 9.600000000000000000
          Width = 211.200000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo8: TfrxDMPMemoView
          Left = 230.400000000000000000
          Width = 115.200000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo9: TfrxDMPMemoView
          Left = 1036.800000000000000000
          Width = 57.600000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValIte: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValTot: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 134.400000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValMed: TfrxDMPMemoView
          Left = 825.600000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREMED"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbUltCom: TfrxDMPMemoView
          Left = 931.200000000000000000
          Width = 96.000000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DTAULT"]')
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbValTotLT: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 134.400000000000000000
          Height = 51.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Frame.Typ = [ftRight, ftBottom]
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 102.000000000000000000
        Top = 17.000000000000000000
        Width = 1104.000000000000000000
        object rllNomeEmpresa: TfrxDMPMemoView
          Align = baCenter
          Left = 163.200000000000000000
          Top = 17.000000000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsxWide, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rllNomeRelatorio: TfrxDMPMemoView
          Align = baCenter
          Left = 307.200000000000000000
          Top = 34.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
          TruncOutboundText = False
        end
        object rllPagina: TfrxDMPMemoView
          Left = 969.600000000000000000
          Top = 34.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
          TruncOutboundText = False
        end
        object DMPMemo1: TfrxDMPMemoView
          Align = baCenter
          Left = 134.400000000000000000
          Top = 68.000000000000000000
          Width = 844.800000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPCommand1: TfrxDMPCommand
          Left = 9.600000000000000000
          Width = 19.200000000000000000
          Height = 17.000000000000000000
          Command = '#27#64#18#27#80#18#27#77'
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 17.000000000000000000
        Top = 357.000000000000000000
        Width = 1104.000000000000000000
        object rdbSumTot: TfrxDMPMemoView
          Left = 537.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
        object DMPMemo13: TfrxDMPMemoView
          Left = 432.000000000000000000
          Width = 96.000000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          FontStyle = [fsxBold, fsx12cpi]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
          TruncOutboundText = False
        end
        object rdbSumTotLT: TfrxDMPMemoView
          Left = 681.600000000000000000
          Width = 134.400000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          WordWrap = False
          TruncOutboundText = False
        end
      end
      object DetailData1: TfrxDetailData
        FillType = ftBrush
        Height = 34.000000000000000000
        Top = 306.000000000000000000
        Width = 1104.000000000000000000
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
        RowCount = 0
        object DMPMemo15: TfrxDMPMemoView
          Left = 576.000000000000000000
          Width = 57.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          FontStyle = [fsx12cpi]
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFormIte."DMT_QTDITE"]')
          ParentFont = False
          WordWrap = False
          TruncOutboundText = False
        end
        object rdbDesIteDet: TfrxDMPMemoView
          Left = 38.400000000000000000
          Width = 364.800000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."DMT_DESCRI"]')
          TruncOutboundText = False
        end
        object DMPMemo17: TfrxDMPMemoView
          Left = 412.800000000000000000
          Width = 153.600000000000000000
          Height = 17.000000000000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          Frame.Typ = [ftRight, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."FAS_DESFAS"]')
          WordWrap = False
          TruncOutboundText = False
        end
      end
    end
  end
  object frxPreCusLitroJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 42927.709299606500000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;'
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;'
      'end;'
      ''
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin{  '
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 39 Then'
      '  Begin'
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    Memo8.Height       := 16;'
      '    Memo6.Height       := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    Memo7.Height       := 16;'
      '    Memo15.Height      := 16;'
      '    Memo13.Height      := 16;'
      '    Shape2.Height      := 16;'
      '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 78 Then'
      '  Begin'
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    Memo8.Height       := 33;'
      '    Memo6.Height       := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    Memo7.Height       := 33;'
      '    Memo15.Height      := 33;'
      '    Memo13.Height      := 33;'
      '    Shape2.Height      := 33;'
      '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 78 Then'
      '  Begin'
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    Memo8.Height       := 50;'
      '    Memo6.Height       := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    Memo7.Height       := 50;'
      '    Memo15.Height      := 50;'
      '    Memo13.Height      := 50;'
      '    Shape2.Height      := 50;'
      '  End;}'
      ''
      '  fAbreFormulaSubItensRel(<frxRelatorio."DMT_ITESUB">);      '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaJUserFunction
    Left = 226
    Top = 520
    Datasets = <
      item
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 296.900000000000000000
      PaperHeight = 241.300000000000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.500000000000000000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 23.433073310000000000
        Top = 204.094620000000000000
        Width = 1046.551857000000000000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
        object Shape2: TfrxShapeView
          Left = 1.889763780000000000
          Width = 1039.370750000000000000
          Height = 18.897635349999990000
        end
        object Memo6: TfrxMemoView
          Left = 374.480210000000000000
          Top = 0.559060000000000000
          Width = 51.779530000000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbDesIte: TfrxMemoView
          Left = 1.852010000000000000
          Top = 0.559060000000000000
          Width = 222.992074720000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 228.957390000000000000
          Top = 0.559060000000000000
          Width = 143.622017950000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbValIte: TfrxMemoView
          Left = 428.512060000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rdbValTot: TfrxMemoView
          Left = 518.220780000000000000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 981.286580000000000000
          Width = 54.425170000000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
        object Memo7: TfrxMemoView
          Left = 776.787880000000000000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_PREMED"]')
          ParentFont = False
          WordWrap = False
        end
        object Memo15: TfrxMemoView
          Left = 878.394250000000000000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."ITE_DTAULT"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbValTotLT: TfrxMemoView
          Left = 650.079160000000000000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 158.740260000000000000
        Width = 1046.551857000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Top = 1.779529999999994000
          Width = 1039.370750000000000000
          Height = 18.897635350000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 374.480209999999700000
          Top = 1.779529999999994000
          Width = 51.779530000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 2.379530000000000000
          Top = 1.779529999999994000
          Width = 222.992074720000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 228.957390000000000000
          Top = 1.779529999999994000
          Width = 143.622017950000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 980.286580000000000000
          Top = 1.779529999999994000
          Width = 58.204700000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 428.512059999999800000
          Top = 1.779529999999994000
          Width = 86.929133859999990000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. ITEM')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 518.220780000000000000
          Top = 1.779529999999994000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL (KG)')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 776.787880000000000000
          Top = 1.779529999999994000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. MEDIO')
          ParentFont = False
        end
        object Memo14: TfrxMemoView
          Left = 878.394250000000000000
          Top = 1.779529999999994000
          Width = 98.267723860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'ULT COMPRA')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 650.079160000000000000
          Top = 1.779529999999994000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'CUS. TOTAL (LT)')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 79.322820000000000000
        Top = 18.897650000000000000
        Width = 1046.551857000000000000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 134.475928500000000000
          Top = 3.661410000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 278.475928500000000000
          Top = 27.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 914.707050000000000000
          Top = 27.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 123.553108500000000000
          Top = 55.000000000000000000
          Width = 799.445640000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 291.023810000000000000
        Width = 1046.551857000000000000
        object rdbSumTot: TfrxMemoView
          Left = 518.220780000000000000
          Top = 3.779530000000051000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 428.512060000000000000
          Top = 3.779530000000051000
          Width = 86.929133859999990000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
        object rdbSumTotLT: TfrxMemoView
          Left = 650.079160000000000000
          Top = 3.779530000000051000
          Width = 120.944903860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
      end
      object detDetalhe: TfrxDetailData
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 249.448980000000000000
        Visible = False
        Width = 1046.551857000000000000
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
        RowCount = 0
        object rdbDesIteDet: TfrxMemoView
          Left = 27.056514720000000000
          Top = 0.755905510000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."ITE_DESITE"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 374.579407950000000000
          Top = 0.755905510000000000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."FAS_DESFAS"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 532.913730000000000000
          Top = 0.755905510000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFormIte."DMT_QTDITE"]')
          ParentFont = False
        end
      end
    end
  end
  object frxFormIte: TfrxDBDataset
    UserName = 'frxFormIte'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 320
    Top = 392
  end
  object frxPaginaJ: TfrxReport
    Version = '5.6.11'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Padr'#227'o'
    PrintOptions.PrintMode = pmScale
    PrintOptions.PrintOnSheet = 9
    ReportOptions.CreateDate = 39343.483190925900000000
    ReportOptions.LastChange = 44622.783291747680000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'procedure rllPaginaOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '  rllPagina.Text := '#39'PAGINA: '#39' + rllPagina.Text;                ' +
        '                                                '
      'end;'
      ''
      'procedure rllTotalImpressoOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      
        '//  rllTotalImpresso.Text := '#39'REGISTROS IMPRESSOS: '#39' + rllTotalI' +
        'mpresso.Text;                                                   ' +
        '                 '
      'end;'
      '  '
      'procedure rlbDetalhesOnBeforePrint(Sender: TfrxComponent);'
      'begin'
      '  If Length(<frxRelatorio."DMT_DESCRI">) < 40 Then'
      '  Begin              '
      '    rlbDetalhes.Height := 16;'
      '    rdbDesIte.Height   := 16;'
      '    Memo8.Height       := 16;'
      '    Memo6.Height       := 16;'
      '    rdbValIte.Height   := 16;'
      '    rdbValTot.Height   := 16;'
      '    Memo13.Height      := 16;'
      '    Shape2.Height      := 16;                                  '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) < 80 Then     ' +
        '                            '
      '  Begin              '
      '    rlbDetalhes.Height := 33;'
      '    rdbDesIte.Height   := 33;'
      '    Memo8.Height       := 33;'
      '    Memo6.Height       := 33;'
      '    rdbValIte.Height   := 33;'
      '    rdbValTot.Height   := 33;'
      '    Memo13.Height      := 33;'
      '    Shape2.Height      := 33;        '
      
        '  End Else If Length(<frxRelatorio."DMT_DESCRI">) > 80 Then     ' +
        '                            '
      '  Begin              '
      '    rlbDetalhes.Height := 50;'
      '    rdbDesIte.Height   := 50;'
      '    Memo8.Height       := 50;'
      '    Memo6.Height       := 50;'
      '    rdbValIte.Height   := 50;'
      '    rdbValTot.Height   := 50;'
      '    Memo13.Height      := 50;'
      '    Shape2.Height      := 50;'
      '  End;'
      ''
      '  fAbreFormulaSubItensRel(<frxRelatorio."DMT_ITESUB">);  '
      '    '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnUserFunction = frxPaginaJUserFunction
    Left = 217
    Top = 376
    Datasets = <
      item
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
      end
      item
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object qckPagina: TfrxReportPage
      PaperWidth = 241.299844160000000000
      PaperHeight = 296.862308280000000000
      PaperSize = 256
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      ColumnWidth = 2.539998359584390000
      object rlbDetalhes: TfrxMasterData
        FillType = ftBrush
        Height = 65.007903310000000000
        Top = 204.094620000000000000
        Width = 836.409399998044800000
        OnBeforePrint = 'rlbDetalhesOnBeforePrint'
        DataSet = frxRelatorio
        DataSetName = 'frxRelatorio'
        PrintIfDetailEmpty = True
        RowCount = 0
        Stretched = True
        object Shape2: TfrxShapeView
          Left = 1.889763780000000000
          Width = 831.496600000000000000
          Height = 60.472465350000000000
        end
        object Memo6: TfrxMemoView
          Left = 535.779530000000000000
          Top = 0.559060000000000000
          Width = 51.779530000000000000
          Height = 56.692937800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[frxRelatorio."DMT_QTDITE"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbDesIte: TfrxMemoView
          Left = 2.379530000000000000
          Top = 0.559060000000000000
          Width = 370.393744720000000000
          Height = 56.692937800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          Memo.UTF8W = (
            '[frxRelatorio."DMT_DESCRI"]')
          ParentFont = False
        end
        object Memo8: TfrxMemoView
          Left = 374.579530000000000000
          Top = 0.559060000000000000
          Width = 158.740137950000000000
          Height = 56.692937800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight]
          Memo.UTF8W = (
            '[frxRelatorio."FAS_DESFAS"]')
          ParentFont = False
          WordWrap = False
        end
        object rdbValIte: TfrxMemoView
          Left = 590.811380000000000000
          Width = 86.929133860000000000
          Height = 56.692937800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object rdbValTot: TfrxMemoView
          Left = 681.520100000000000000
          Width = 86.929133860000000000
          Height = 56.692937800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo13: TfrxMemoView
          Left = 771.379530000000000000
          Width = 58.204700000000000000
          Height = 52.913407800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          ParentFont = False
          WordWrap = False
        end
      end
      object rlbTitulo: TfrxHeader
        FillType = ftBrush
        Height = 20.763760000000000000
        Top = 158.740260000000000000
        Width = 836.409399998044800000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Left = 1.889763780000000000
          Top = 1.779529999999990000
          Width = 831.496600000000000000
          Height = 18.897635350000000000
          Fill.BackColor = clSilver
        end
        object Memo2: TfrxMemoView
          Left = 535.779530000000000000
          Top = 1.779530000000000000
          Width = 51.779530000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'QTD')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 2.379530000000000000
          Top = 1.779530000000000000
          Width = 370.393744720000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'ITEM')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 374.579530000000000000
          Top = 1.779530000000000000
          Width = 158.740137950000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft, ftRight]
          HAlign = haCenter
          Memo.UTF8W = (
            'FASE')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 771.379530000000000000
          Top = 1.779530000000000000
          Width = 58.204700000000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haCenter
          Memo.UTF8W = (
            'STATUS')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 590.811380000000000000
          Top = 1.779530000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. ITEM')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Left = 681.520100000000000000
          Top = 1.779530000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftLeft]
          HAlign = haRight
          Memo.UTF8W = (
            'VLR. TOTAL')
          ParentFont = False
        end
      end
      object rlbCabecalho: TfrxPageHeader
        FillType = ftBrush
        Height = 79.322820000000000000
        Top = 18.897650000000000000
        Width = 836.409399998044800000
        object rllNomeEmpresa: TfrxMemoView
          Align = baCenter
          Left = 29.404699999022400000
          Top = 3.661410000000000000
          Width = 777.600000000000000000
          Height = 17.000000000000000000
          DataSet = frmPaiRelatorio.frxGen
          DataSetName = 'frxGen'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[EMPRESA]')
          ParentFont = False
          WordWrap = False
        end
        object rllNomeRelatorio: TfrxMemoView
          Align = baCenter
          Left = 173.404699999022400000
          Top = 27.000000000000000000
          Width = 489.600000000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          HAlign = haCenter
          Memo.UTF8W = (
            'CHECK LIST EXPEDICAO')
          WordWrap = False
        end
        object rllPagina: TfrxMemoView
          Left = 701.707050000000000000
          Top = 27.000000000000000000
          Width = 124.800000000000000000
          Height = 17.000000000000000000
          OnBeforePrint = 'rllPaginaOnBeforePrint'
          HAlign = haRight
          Memo.UTF8W = (
            '[Page]')
        end
        object Memo1: TfrxMemoView
          Align = baCenter
          Left = 18.481879999022400000
          Top = 55.000000000000000000
          Width = 799.445640000000000000
          Height = 17.000000000000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[ESTRUTURA]')
          ParentFont = False
          WordWrap = False
        end
      end
      object Footer1: TfrxFooter
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 332.598640000000000000
        Width = 836.409399998044800000
        object rdbSumTot: TfrxMemoView
          Left = 684.520100000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DataSet = frxRelatorio
          DataSetName = 'frxRelatorio'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          ParentFont = False
          WordWrap = False
        end
        object Memo11: TfrxMemoView
          Left = 593.811380000000000000
          Width = 86.929133860000000000
          Height = 18.897637800000000000
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            'TOTAL')
          ParentFont = False
        end
      end
      object detDetalhe: TfrxDetailData
        FillType = ftBrush
        Height = 17.763779530000000000
        Top = 291.023810000000000000
        Visible = False
        Width = 836.409399998044800000
        DataSet = frxFormIte
        DataSetName = 'frxFormIte'
        RowCount = 0
        object rdbDesIteDet: TfrxMemoView
          Left = 27.056514720000000000
          Top = 0.755905510000000000
          Width = 347.716760000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."ITE_DESITE"]')
          ParentFont = False
        end
        object Memo12: TfrxMemoView
          Left = 374.579407950000000000
          Top = 0.755905510000000000
          Width = 158.740260000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftBottom]
          Memo.UTF8W = (
            '[frxFormIte."FAS_DESFAS"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 532.913730000000000000
          Top = 0.755905510000000000
          Width = 56.692950000000000000
          Height = 15.118120000000000000
          StretchMode = smMaxHeight
          DisplayFormat.FormatStr = '%2.4f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[frxFormIte."DMT_QTDITE"]')
          ParentFont = False
        end
      end
    end
  end
  object memLogTemp: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 360
    Top = 320
    object memLogTempLGF_CODITE: TStringField
      FieldName = 'LGF_CODITE'
      Size = 10
    end
    object memLogTempLGF_CODEMP: TStringField
      FieldName = 'LGF_CODEMP'
      Size = 3
    end
    object memLogTempLGF_FORMUL: TStringField
      FieldName = 'LGF_FORMUL'
      Size = 10
    end
    object memLogTempLGF_DTAHRA: TStringField
      FieldName = 'LGF_DTAHRA'
      Size = 30
    end
    object memLogTempLGF_CODOPE: TStringField
      FieldName = 'LGF_CODOPE'
      Size = 3
    end
    object memLogTempLGF_ITESUB: TStringField
      FieldName = 'LGF_ITESUB'
      Size = 10
    end
    object memLogTempLGF_INFALT: TStringField
      FieldName = 'LGF_INFALT'
      Size = 30
    end
    object memLogTempLGF_VALANT: TStringField
      FieldName = 'LGF_VALANT'
      Size = 30
    end
    object memLogTempLGF_VALATU: TStringField
      FieldName = 'LGF_VALATU'
      Size = 30
    end
    object memLogTempLGF_CODCOR: TStringField
      FieldName = 'LGF_CODCOR'
      Size = 4
    end
  end
end
