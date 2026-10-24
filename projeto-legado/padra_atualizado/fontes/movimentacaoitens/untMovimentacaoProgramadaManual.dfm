inherited frmMovimentacaoProgramadaManual: TfrmMovimentacaoProgramadaManual
  Width = 1024
  Height = 766
  BorderIcons = [biSystemMenu, biMinimize, biMaximize]
  BorderStyle = bsSingle
  Caption = 'Gera'#231#227'o de Movimenta'#231#227'o Programada'
  Position = poMainFormCenter
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  ExplicitWidth = 1024
  ExplicitHeight = 766
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      inherited btnConfirma: TBitBtnLocked
        Width = 201
        Caption = '[ F10 ] Gravar Movimenta'#231#245'es'
        ModalResult = 0
        ExplicitWidth = 201
      end
      object btnDigitacaoGlobal: TBitBtnLocked
        Left = 201
        Top = 0
        Width = 286
        Height = 22
        Caption = '[ F5 ] Digita'#231#227'o Global - Itens pr'#243'ximos ao vencimento'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333330000333333333333333333333333F33333333333
          00003333344333333333333333388F3333333333000033334224333333333333
          338338F3333333330000333422224333333333333833338F3333333300003342
          222224333333333383333338F3333333000034222A22224333333338F338F333
          8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
          33333338F83338F338F33333000033A33333A222433333338333338F338F3333
          0000333333333A222433333333333338F338F33300003333333333A222433333
          333333338F338F33000033333333333A222433333333333338F338F300003333
          33333333A222433333333333338F338F00003333333333333A22433333333333
          3338F38F000033333333333333A223333333333333338F830000333333333333
          333A333333333333333338330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnDigitacaoGlobalClick
      end
      object btnRelatorio: TBitBtnLocked
        Left = 487
        Top = 0
        Width = 109
        Height = 22
        Caption = '&Relat'#243'rio'
        TabOrder = 3
        OnClick = btnRelatorioClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 596
        Top = 0
        Width = 103
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
        TabOrder = 2
        OnClick = btnExcluirClick
      end
      object btnExcluirMovProgramada: TBitBtnLocked
        Left = 699
        Top = 0
        Width = 231
        Height = 22
        Caption = '[F7] -  Excluir Movimenta'#231#227'o Programada'
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
        TabOrder = 4
        OnClick = btnExcluirMovProgramadaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 938
      Top = 2
      ExplicitLeft = 938
      ExplicitTop = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 721
    Width = 1018
    ExplicitTop = 721
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  object prgProgresso: TProgressBar [2]
    Left = 0
    Top = 679
    Width = 1018
    Height = 16
    Align = alBottom
    Smooth = True
    TabOrder = 2
    Visible = False
  end
  object pagPageControl: TPageControl [3]
    Left = 0
    Top = 28
    Width = 1018
    Height = 651
    ActivePage = tbsAbastecimento
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    OnChange = pagPageControlChange
    object tbsManual: TTabSheet
      Caption = 'Movimenta'#231#227'o programada manual'
      object pnlItem: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 205
        Align = alTop
        BevelInner = bvRaised
        BevelOuter = bvNone
        Enabled = False
        ParentColor = True
        TabOrder = 0
        object Label1: TLabel
          Left = 63
          Top = 6
          Width = 56
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Produto:'
        end
        object lblOrigem: TLabel
          Left = 26
          Top = 52
          Width = 93
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Lote de Origem:'
        end
        object lblDestino: TLabel
          Left = 3
          Top = 150
          Width = 116
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Localiza'#231#227'o de Destino:'
        end
        object Label4: TLabel
          Left = 23
          Top = 179
          Width = 96
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Quantidade:'
        end
        object Label2: TLabel
          Left = 63
          Top = 31
          Width = 56
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Marca:'
        end
        object Label3: TLabel
          Left = 526
          Top = 31
          Width = 56
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = 'Unidade:'
        end
        object lblOpeDest: TLabel
          Left = 280
          Top = 150
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Operador destino:'
        end
        object dbeCodIte: TDBEditFocus
          Tag = 99
          Left = 121
          Top = 3
          Width = 54
          Height = 22
          DataField = 'CODITE'
          DataSource = dtsItens
          TabOrder = 0
          OnKeyPress = dbeCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDesIte: TDBEditFocus
          Left = 175
          Top = 3
          Width = 465
          Height = 22
          TabStop = False
          Color = 16768952
          DataField = 'DESITE'
          DataSource = dtsItens
          ReadOnly = True
          TabOrder = 6
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeLotOri: TDBEditFocus
          Tag = 99
          Left = 121
          Top = 49
          Width = 95
          Height = 22
          DataField = 'LOTORI'
          DataSource = dtsItens
          TabOrder = 1
          OnKeyPress = dbeLotOriKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeLocDes: TDBEditFocus
          Tag = 99
          Left = 121
          Top = 146
          Width = 95
          Height = 22
          DataField = 'LOCDES'
          DataSource = dtsItens
          TabOrder = 2
          OnChange = dbeLocDesChange
          OnKeyPress = dbeLocDesKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object btnAdicionar: TBitBtnLocked
          Left = 223
          Top = 175
          Width = 81
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
          TabOrder = 7
          OnClick = btnAdicionarClick
        end
        object btnCancelaItem: TBitBtnLocked
          Left = 306
          Top = 175
          Width = 81
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
          TabOrder = 8
          OnClick = btnCancelaItemClick
        end
        object dbeQtdIte: TDBEditFocus
          Tag = 99
          Left = 121
          Top = 175
          Width = 95
          Height = 22
          DataField = 'QTDITE'
          DataSource = dtsItens
          TabOrder = 5
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeDesMar: TDBEditFocus
          Left = 175
          Top = 26
          Width = 345
          Height = 22
          TabStop = False
          Color = 16768952
          DataField = 'DESMAR'
          DataSource = dtsItens
          ReadOnly = True
          TabOrder = 9
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeCodMar: TDBEditFocus
          Left = 121
          Top = 26
          Width = 54
          Height = 22
          TabStop = False
          Color = 16768952
          DataField = 'CODMAR'
          DataSource = dtsItens
          ReadOnly = True
          TabOrder = 10
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object dbeSigUni: TDBEditFocus
          Left = 586
          Top = 26
          Width = 54
          Height = 22
          TabStop = False
          Color = 16768952
          DataField = 'SIGUNI'
          DataSource = dtsItens
          ReadOnly = True
          TabOrder = 11
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object grbOrigem: TGroupBox
          Left = 102
          Top = 77
          Width = 517
          Height = 62
          Caption = 'Lote de Origem:'
          TabOrder = 12
          object lblSalOri: TLabel
            Left = 19
            Top = 16
            Width = 61
            Height = 14
            Caption = 'Saldo F'#237'sico:'
          end
          object lblMaxOri: TLabel
            Left = 395
            Top = 16
            Width = 92
            Height = 14
            Caption = 'Localiza'#231#227'o F'#237'sica:'
          end
          object Label7: TLabel
            Left = 149
            Top = 16
            Width = 89
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Saldo Reservado:'
          end
          object Label8: TLabel
            Left = 276
            Top = 16
            Width = 82
            Height = 14
            AutoSize = False
            Caption = 'Saldo Dispon'#237'vel:'
          end
          object dbeSalOri: TDBEditFocus
            Left = 19
            Top = 31
            Width = 110
            Height = 22
            TabStop = False
            Color = 16768952
            DataField = 'SALORI'
            DataSource = dtsItens
            ReadOnly = True
            TabOrder = 0
            NormalColor = 16768952
            FocusColor = 16768952
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeMaxOri: TDBEditFocus
            Left = 395
            Top = 31
            Width = 111
            Height = 22
            TabStop = False
            Color = 16768952
            DataField = 'MAXORI'
            DataSource = dtsItens
            ReadOnly = True
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = 16768952
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeSalOriRes: TDBEditFocus
            Left = 149
            Top = 31
            Width = 103
            Height = 22
            TabStop = False
            Color = 16768952
            DataField = 'SALORIRES'
            DataSource = dtsItens
            ReadOnly = True
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = 16768952
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeSalOriDis: TDBEditFocus
            Left = 275
            Top = 31
            Width = 103
            Height = 22
            TabStop = False
            Color = 16768952
            DataField = 'SALORIDIS'
            DataSource = dtsItens
            ReadOnly = True
            TabOrder = 2
            NormalColor = 16768952
            FocusColor = 16768952
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object edtCodOpeDest: TDBEditFocus
          Tag = 99
          Left = 369
          Top = 145
          Width = 54
          Height = 22
          DataField = 'OPEDES'
          DataSource = dtsItens
          TabOrder = 3
          OnKeyPress = edtCodOpeDestKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object edtNomOpeDest: TDBEditFocus
          Left = 424
          Top = 145
          Width = 216
          Height = 22
          TabStop = False
          Color = 16768952
          DataField = 'NOMOPEDES'
          DataSource = dtsItens
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 4
          NormalColor = 16768952
          FocusColor = 16768952
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
      object cxgItens: TcxGridCitel
        Left = 0
        Top = 205
        Width = 1010
        Height = 414
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgItensView: TcxGridDBTableViewCitel
          OnKeyDown = cxgItensViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = cxgItensViewCellDblClick
          OnCustomDrawCell = cxgItensViewCustomDrawCell
          DataController.DataSource = dtsGrid
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = True
          CorZebra = clMoneyGreen
          object cxgItensViewColumn1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODITE'
            Width = 45
          end
          object cxgItensViewColumn2: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESITE'
            Width = 335
          end
          object cxgItensViewColumn6: TcxGridDBColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'DESMAR'
            Width = 150
          end
          object cxgItensViewColumn7: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'SIGUNI'
            Width = 60
          end
          object cxgItensViewColumn8: TcxGridDBColumn
            Caption = 'Lote de Origem'
            DataBinding.FieldName = 'LOTORI'
            Width = 120
          end
          object cxgItensViewColumn3: TcxGridDBColumn
            Caption = 'Loc. F'#237'sica Origem'
            DataBinding.FieldName = 'LOCORI'
            Width = 120
          end
          object cxgItensViewColumn9: TcxGridDBColumn
            Caption = 'Pk'
            DataBinding.FieldName = 'ORIPIC'
            Width = 25
          end
          object cxgItensViewColumn4: TcxGridDBColumn
            Caption = 'Loc. de Destino '
            DataBinding.FieldName = 'LOCDES'
            Width = 120
          end
          object cxgItensViewColumn10: TcxGridDBColumn
            Caption = 'Pk'
            DataBinding.FieldName = 'DESPIC'
            Width = 25
          end
          object cxgItensViewColumn5: TcxGridDBColumn
            Caption = 'Quantidade'
            DataBinding.FieldName = 'QTDITE'
            HeaderAlignmentHorz = taRightJustify
            Width = 70
          end
          object cxgItensViewMAXDES: TcxGridDBColumn
            Caption = 'Qtd. M'#225'x. Loc. Dest.'
            DataBinding.FieldName = 'MAXDES'
            Width = 120
          end
          object cxgItensViewColumnOPEDES: TcxGridDBColumn
            Caption = 'Operador de Destino'
            DataBinding.FieldName = 'OPEDES'
            OnGetDisplayText = cxgItensViewColumnOPEDESGetDisplayText
            Width = 197
          end
        end
        object cxgItensLevel1: TcxGridLevel
          GridView = cxgItensView
        end
      end
    end
    object tbsAbastecimento: TTabSheet
      Caption = 'Movimenta'#231#227'o programada - Abastecimento preventivo'
      ImageIndex = 1
      OnEnter = tbsAbastecimentoEnter
      OnShow = tbsAbastecimentoShow
      object pnlFiltrosAbastPrev: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 161
        Align = alTop
        BevelOuter = bvNone
        Enabled = False
        TabOrder = 0
        object grpFiltrosAbastPrev: TGroupBox
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 942
          Height = 155
          Align = alLeft
          Caption = 'Abastecimento preventivo no picking'
          TabOrder = 0
          object lblOperador: TLabel
            Left = 13
            Top = 132
            Width = 49
            Height = 14
            Alignment = taRightJustify
            Caption = 'Operador:'
          end
          object chkConsiderarMvtoAndamento: TCheckBox
            Left = 16
            Top = 22
            Width = 425
            Height = 17
            Caption = 
              'Considerar movimenta'#231#245'es em andamento (mov. programada e separa'#231 +
              #227'o)    '
            TabOrder = 0
            OnClick = chkConsiderarMvtoAndamentoClick
          end
          object chkConsidEmbFechada: TCheckBox
            Left = 16
            Top = 40
            Width = 225
            Height = 17
            Caption = 'Considerar embalagem fechada'
            TabOrder = 1
          end
          object chkAbastItensCapMax: TCheckBox
            Left = 16
            Top = 58
            Width = 345
            Height = 17
            Caption = 
              'Abastecer itens que estejam                   % da capacidade m'#225 +
              'xima'
            TabOrder = 2
          end
          object edtCapMax: TEditFocus
            Tag = 99
            Left = 176
            Top = 55
            Width = 47
            Height = 22
            Alignment = taRightJustify
            TabOrder = 3
            Text = '100'
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttNumerico
          end
          object grpNivGir: TcxGroupBox
            Left = 16
            Top = 77
            Caption = 'N'#237'vel de Giro'
            ParentFont = False
            Style.Font.Charset = DEFAULT_CHARSET
            Style.Font.Color = clBlack
            Style.Font.Height = 14
            Style.Font.Name = 'Arial'
            Style.Font.Pitch = fpVariable
            Style.Font.Style = []
            Style.Shadow = True
            Style.IsFontAssigned = True
            TabOrder = 4
            Height = 44
            Width = 244
            object lblNivGir: TColorLabel
              Left = 34
              Top = 21
              Width = 186
              Height = 14
              Caption = 'N'#237'vel (A)   N'#237'vel(B)   N'#237'vel (C)   (T)odos'
              CorDestaque = clRed
            end
            object edtGirEst: TEditFocus
              Tag = 99
              Left = 10
              Top = 17
              Width = 18
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              TabOrder = 0
              Text = 'T'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfabetico
            end
          end
          object edtCodOpe: TEditFocus
            Tag = 99
            Left = 68
            Top = 127
            Width = 54
            Height = 22
            Alignment = taLeftJustify
            CharCase = ecUpperCase
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 10
            TabOrder = 5
            OnKeyPress = edtCodOpeKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtNomOpe: TEditFocus
            Left = 124
            Top = 127
            Width = 226
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ReadOnly = True
            TabOrder = 6
            NormalColor = 16768952
            FocusColor = 16768952
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object btnPesquisar: TBitBtnLocked
            Left = 375
            Top = 127
            Width = 81
            Height = 22
            Caption = '&Pesquisar'
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
            TabOrder = 7
            OnClick = btnPesquisarClick
          end
          object btnLimparFiltrosAbast: TBitBtnLocked
            Left = 462
            Top = 127
            Width = 81
            Height = 22
            Caption = '&Limpar'
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
            TabOrder = 8
            OnClick = btnLimparFiltrosAbastClick
          end
          object gpbOrdemSugest: TGroupBox
            Left = 507
            Top = 22
            Width = 333
            Height = 91
            Caption = 'Ordem de sugest'#227'o de lotes'
            TabOrder = 9
            object lbxOrdemSugest: TListBox
              AlignWithMargins = True
              Left = 5
              Top = 19
              Width = 296
              Height = 67
              Align = alClient
              ItemHeight = 14
              Items.Strings = (
                'Localiza'#231#227'o f'#237'sica'
                'Data de validade'
                'Proximidade do picking'
                'Data de balan'#231'o')
              TabOrder = 0
            end
            object pnlControleOrdem: TPanel
              Left = 304
              Top = 16
              Width = 27
              Height = 73
              Align = alRight
              BevelOuter = bvNone
              TabOrder = 1
              object btnUp: TSpeedButton
                AlignWithMargins = True
                Left = 3
                Top = 5
                Width = 21
                Height = 22
                Cursor = crHandPoint
                Hint = 'Sobe a Coluna'
                Margins.Top = 5
                Align = alTop
                Flat = True
                Glyph.Data = {
                  76010000424D7601000000000000760000002800000020000000100000000100
                  04000000000000010000120B0000120B00001000000000000000000000000000
                  800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000333
                  3333333333777F33333333333309033333333333337F7F333333333333090333
                  33333333337F7F33333333333309033333333333337F7F333333333333090333
                  33333333337F7F33333333333309033333333333FF7F7FFFF333333000090000
                  3333333777737777F333333099999990333333373F3333373333333309999903
                  333333337F33337F33333333099999033333333373F333733333333330999033
                  3333333337F337F3333333333099903333333333373F37333333333333090333
                  33333333337F7F33333333333309033333333333337373333333333333303333
                  333333333337F333333333333330333333333333333733333333}
                NumGlyphs = 2
                ParentShowHint = False
                ShowHint = True
                OnClick = btnUpClick
                ExplicitLeft = 4
                ExplicitTop = 12
                ExplicitWidth = 23
              end
              object btnDown: TSpeedButton
                AlignWithMargins = True
                Left = 3
                Top = 33
                Width = 21
                Height = 22
                Cursor = crHandPoint
                Hint = 'Desce a Coluna'
                Align = alTop
                Flat = True
                Glyph.Data = {
                  76010000424D7601000000000000760000002800000020000000100000000100
                  04000000000000010000120B0000120B00001000000000000000000000000000
                  800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
                  FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333303333
                  333333333337F33333333333333033333333333333373F333333333333090333
                  33333333337F7F33333333333309033333333333337373F33333333330999033
                  3333333337F337F33333333330999033333333333733373F3333333309999903
                  333333337F33337F33333333099999033333333373333373F333333099999990
                  33333337FFFF3FF7F33333300009000033333337777F77773333333333090333
                  33333333337F7F33333333333309033333333333337F7F333333333333090333
                  33333333337F7F33333333333309033333333333337F7F333333333333090333
                  33333333337F7F33333333333300033333333333337773333333}
                NumGlyphs = 2
                ParentShowHint = False
                ShowHint = True
                OnClick = btnDownClick
                ExplicitTop = 32
                ExplicitWidth = 27
              end
            end
          end
        end
      end
      object cxDados: TcxGridCitel
        Left = 0
        Top = 161
        Width = 1010
        Height = 430
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgDados: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsDados
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'CHAVE_MASTER'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.ShowEditButtons = gsebAlways
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgDadosITE_SELECE: TcxGridDBColumn
            Caption = 'Selecionar'
            DataBinding.FieldName = 'ITE_SELECE'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Properties.OnChange = cxgDadosITE_SELECEPropertiesChange
          end
          object cxgDadosITE_CODITE: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'ITE_CODITE'
            Options.Editing = False
          end
          object cxgDadosITE_DESITE: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'ITE_DESITE'
            MinWidth = 100
            Options.Editing = False
            Width = 286
          end
          object cxgDadosMAR_DESMAR: TcxGridDBColumn
            Caption = 'Marca'
            DataBinding.FieldName = 'MAR_DESMAR'
            MinWidth = 64
            Options.Editing = False
          end
          object cxgDadosUNI_DESUNI: TcxGridDBColumn
            Caption = 'Unidade'
            DataBinding.FieldName = 'UNI_DESUNI'
            Options.Editing = False
          end
          object cxgDadosBAR_EMBALA: TcxGridDBColumn
            Caption = 'Embalagem'
            DataBinding.FieldName = 'BAR_EMBALA'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
          end
          object cxgDadosLOC_PONREP: TcxGridDBColumn
            Caption = 'Ponto de reposi'#231#227'o'
            DataBinding.FieldName = 'LOC_PONREP'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 99
          end
          object cxgDadosLOC_CAPACI: TcxGridDBColumn
            Caption = 'Capacidade m'#225'xima'
            DataBinding.FieldName = 'LOC_CAPACI'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 102
          end
          object cxgDadosCAPACIDADE_CALCULADA: TcxGridDBColumn
            Caption = 'Capacidade Calculada'
            DataBinding.FieldName = 'CAPACIDADE_CALCULADA'
            Options.Editing = False
            Width = 120
          end
          object cxgDadosLOC_CODLOC: TcxGridDBColumn
            Caption = 'Localiza'#231#227'o de destino'
            DataBinding.FieldName = 'LOC_CODLOC'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 117
          end
          object cxgDadosITE_SALFIS: TcxGridDBColumn
            Caption = 'Saldo'
            DataBinding.FieldName = 'ITE_SALFIS'
            Options.Editing = False
          end
          object cxgDadosMLT_QTDMOV: TcxGridDBColumn
            Caption = 'Em movimenta'#231#227'o'
            DataBinding.FieldName = 'ITE_QTDMOV'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 104
          end
          object cxgDadosLOC_QTDSEP: TcxGridDBColumn
            Caption = 'Em separa'#231#227'o'
            DataBinding.FieldName = 'ITE_QTDSEP'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Width = 75
          end
          object cxgDadosITE_SALDES: TcxGridDBColumn
            Caption = 'Saldo P'#243's Movimenta'#231#245'es'
            DataBinding.FieldName = 'ITE_SALDOS'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxVerde
            Width = 138
          end
          object cxgDadosITE_SUGUNI: TcxGridDBColumn
            Caption = 'Sugest'#227'o unit'#225'ria'
            DataBinding.FieldName = 'ITE_SUGUNI'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxAmarelo
            Width = 90
          end
          object cxgDadosITE_SUGEMB: TcxGridDBColumn
            Caption = 'Sugest'#227'o embalagem'
            DataBinding.FieldName = 'ITE_SUGEMB'
            HeaderAlignmentHorz = taCenter
            Options.Editing = False
            Styles.Content = cxAmarelo
            Width = 109
          end
        end
        object cxgDetalhe: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          OnEditKeyPress = cxgDetalheEditKeyPress
          DataController.DataSource = dtsDetalhes
          DataController.DetailKeyFieldNames = 'CHAVE_MASTER'
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.KeyFieldNames = 'CHAVE_FILHO'
          DataController.MasterKeyFieldNames = 'CHAVE_MASTER'
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgDetalheLOT_SELECE_DETAIL: TcxGridDBColumn
            Caption = 'Selecionar'
            DataBinding.FieldName = 'LOT_SELECE_DETAIL'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxgDetalheLOT_NUMLOT: TcxGridDBColumn
            Caption = 'Lote de origem'
            DataBinding.FieldName = 'LOT_NUMLOT'
          end
          object cxgDetalheLOT_LOCFIS: TcxGridDBColumn
            Caption = 'Loc. Fisica de origem'
            DataBinding.FieldName = 'LOT_LOCFIS'
            Options.Editing = False
            SortIndex = 0
            SortOrder = soAscending
          end
          object cxgDetalheQTD_TRANSF: TcxGridDBColumn
            Caption = 'Quantidade a transf.'
            DataBinding.FieldName = 'QTD_TRANSF'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.DisplayFormat = '0.00'
            Options.Editing = False
          end
          object cxgDetalheLOT_DTAVAL: TcxGridDBColumn
            Caption = 'Validade'
            DataBinding.FieldName = 'LOT_DTAVAL'
            Options.Editing = False
          end
          object cxgDetalheLOT_DTABAL: TcxGridDBColumn
            Caption = 'Balan'#231'o'
            DataBinding.FieldName = 'LOT_DTABAL'
            Options.Editing = False
          end
          object cxgDetalheLOT_DISTAN: TcxGridDBColumn
            Caption = 'Dist'#226'ncia'
            DataBinding.FieldName = 'DISTANCIA'
            Options.Editing = False
          end
        end
        object cxlDados: TcxGridLevel
          GridView = cxgDados
          object cxlDetalhe: TcxGridLevel
            GridView = cxgDetalhe
          end
        end
      end
      object FlowPanel1: TFlowPanel
        AlignWithMargins = True
        Left = 3
        Top = 594
        Width = 1004
        Height = 22
        Align = alBottom
        BevelOuter = bvNone
        ShowCaption = False
        TabOrder = 2
        object btnMarDes: TBitBtnLocked
          Left = 0
          Top = 0
          Width = 145
          Height = 22
          Caption = '[SPACE] Marcar/Desmarca'
          TabOrder = 2
          OnClick = btnMarDesClick
        end
        object btnMarTodos: TBitBtnLocked
          Left = 145
          Top = 0
          Width = 134
          Height = 22
          Caption = '[F2] Marcar todos'
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
          OnClick = btnMarTodosClick
        end
        object btnDesmarTodos: TBitBtnLocked
          Left = 279
          Top = 0
          Width = 134
          Height = 22
          Caption = '[F3] Desmarcar todos'
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
          TabOrder = 1
          OnClick = btnDesmarTodosClick
        end
        object lblExpandirRecolherEtiquetasID: TLabel
          AlignWithMargins = True
          Left = 416
          Top = 3
          Width = 88
          Height = 14
          Cursor = crHandPoint
          Caption = 'Expandir/Recolher'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlue
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsUnderline]
          ParentFont = False
          OnClick = lblExpandirRecolherEtiquetasIDClick
        end
      end
    end
  end
  object pnlCabec: TPanel [4]
    Left = 0
    Top = 0
    Width = 1018
    Height = 28
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 4
    object lblDigita: TLabel
      Left = 74
      Top = 9
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Digitador:'
    end
    object edtSenDig: TEditFocus
      Tag = 99
      Left = 121
      Top = 3
      Width = 54
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      PasswordChar = '*'
      TabOrder = 0
      OnExit = edtSenDigExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomDig: TEditFocus
      Left = 175
      Top = 3
      Width = 464
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = 16768952
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 224
    Top = 344
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 192
    Top = 344
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 160
    Top = 392
  end
  object dtsGrid: TDataSource
    DataSet = cdsItens
    Left = 224
    Top = 392
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    Params = <>
    Left = 192
    Top = 392
    object cdsItensCODITE: TStringField
      DisplayWidth = 20
      FieldName = 'CODITE'
    end
    object cdsItensLOTORI: TStringField
      FieldName = 'LOTORI'
    end
    object cdsItensLOTDES: TStringField
      FieldName = 'LOTDES'
    end
    object cdsItensQTDITE: TFloatField
      FieldName = 'QTDITE'
    end
    object cdsItensSALORI: TFloatField
      FieldName = 'SALORI'
    end
    object cdsItensSALDES: TFloatField
      FieldName = 'SALDES'
    end
    object cdsItensMAXORI: TFloatField
      FieldName = 'MAXORI'
    end
    object cdsItensMAXDES: TFloatField
      FieldName = 'MAXDES'
    end
    object cdsItensREPORI: TFloatField
      FieldName = 'REPORI'
    end
    object cdsItensREPDES: TFloatField
      FieldName = 'REPDES'
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 70
    end
    object cdsItensSALDOS: TFloatField
      FieldName = 'SALDOS'
    end
    object cdsItensPRECUS: TFloatField
      FieldName = 'PRECUS'
    end
    object cdsItensLOCORI: TStringField
      FieldName = 'LOCORI'
    end
    object cdsItensLOCDES: TStringField
      FieldName = 'LOCDES'
    end
    object cdsItensDESLFO: TStringField
      FieldName = 'DESLFO'
      Size = 50
    end
    object cdsItensDESLFD: TStringField
      FieldName = 'DESLFD'
      Size = 50
    end
    object cdsItensCODMAR: TStringField
      FieldName = 'CODMAR'
      Size = 6
    end
    object cdsItensDESMAR: TStringField
      FieldName = 'DESMAR'
      Size = 30
    end
    object cdsItensSIGUNI: TStringField
      FieldName = 'SIGUNI'
      Size = 4
    end
    object cdsItensDTAVAL: TDateField
      FieldName = 'DTAVAL'
    end
    object cdsItensSALORIRES: TFloatField
      FieldName = 'SALORIRES'
    end
    object cdsItensSALORIDIS: TFloatField
      FieldName = 'SALORIDIS'
    end
    object cdsItensSALDESRES: TFloatField
      FieldName = 'SALDESRES'
    end
    object cdsItensSALDESDIS: TFloatField
      FieldName = 'SALDESDIS'
    end
    object cdsItensAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsItensORIPIC: TStringField
      FieldName = 'ORIPIC'
      Size = 1
    end
    object cdsItensDESPIC: TStringField
      FieldName = 'DESPIC'
      Size = 1
    end
    object cdsItensQTDDIF: TFloatField
      FieldName = 'QTDDIF'
    end
    object cdsItensOPEDES: TStringField
      FieldName = 'OPEDES'
      Size = 3
    end
    object cdsItensNOMOPEDES: TStringField
      FieldName = 'NOMOPEDES'
      Size = 60
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 160
    Top = 344
  end
  object cxStyleRepository: TcxStyleRepository
    Left = 300
    Top = 344
    PixelsPerInch = 96
    object cxAmarelo: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
    object cxVerde: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object dtsDados: TDataSource
    Left = 500
    Top = 372
  end
  object dtsDetalhes: TDataSource
    Left = 596
    Top = 352
  end
end
