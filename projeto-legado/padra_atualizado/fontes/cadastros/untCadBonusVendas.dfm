inherited frmCadBonusVendas: TfrmCadBonusVendas
  Left = 324
  Top = 246
  Width = 700
  Height = 522
  BorderIcons = [biSystemMenu]
  Caption = 'Cadastro de B'#244'nus de Vendas'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 700
  ExplicitHeight = 522
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 449
    Width = 694
    ExplicitTop = 449
    ExplicitWidth = 694
    DesignSize = (
      694
      28)
    inherited FlwBotoes: TFlowPanel
      Width = 690
      ExplicitTop = 2
      ExplicitWidth = 690
      ExplicitHeight = 24
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F10 ] Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnExcluir: TBitBtnLocked
        Left = 120
        Top = 0
        Width = 120
        Height = 22
        Caption = '[ F11 ] Excluir'
        Enabled = False
        TabOrder = 1
        OnClick = btnExcluirClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 614
      Top = 2
      ExplicitLeft = 614
      ExplicitTop = 2
    end
  end
  object pnlBonus: TPanel [2]
    Left = 0
    Top = 0
    Width = 694
    Height = 84
    Align = alTop
    Color = 16770261
    TabOrder = 2
    object Label1: TLabel
      Left = 28
      Top = 16
      Width = 33
      Height = 14
      AutoSize = False
      Caption = 'B'#244'nus:'
    end
    object Label2: TLabel
      Left = 181
      Top = 16
      Width = 58
      Height = 14
      AutoSize = False
      Caption = 'Descri'#231#227'o:'
    end
    object Label3: TLabel
      Left = 34
      Top = 41
      Width = 29
      Height = 14
      AutoSize = False
      Caption = 'Rede:'
    end
    object Label5: TLabel
      Left = 26
      Top = 63
      Width = 36
      Height = 14
      AutoSize = False
      Caption = 'Cliente:'
    end
    object edtDesRed: TEditFocus
      Left = 173
      Top = 31
      Width = 510
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
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
    object edtDesCli: TEditFocus
      Left = 173
      Top = 55
      Width = 510
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      Enabled = False
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesBmg: TEditFocus
      Tag = 99
      Left = 234
      Top = 7
      Width = 449
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 40
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodBmg: TEditFocus
      Left = 63
      Top = 7
      Width = 110
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 6
      TabOrder = 0
      OnExit = edtCodBmgExit
      OnKeyPress = edtCodBmgKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
    end
    object edtCodRed: TEditFocus
      Tag = 99
      Left = 63
      Top = 31
      Width = 110
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 5
      TabOrder = 2
      OnExit = edtCodRedExit
      OnKeyPress = edtCodRedKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 63
      Top = 55
      Width = 110
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 8
      TabOrder = 4
      OnExit = edtCodCliExit
      OnKeyPress = edtCodCliKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
  end
  object pgcDados: TPageControl [3]
    Left = 0
    Top = 84
    Width = 694
    Height = 281
    ActivePage = tbsProdutos
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    TabStop = False
    OnChange = pgcDadosChange
    object tbsProdutos: TTabSheet
      Caption = '&Produtos'
      object pnlProdutos: TPanel
        Left = 0
        Top = 0
        Width = 686
        Height = 82
        Align = alTop
        Color = 16770261
        TabOrder = 0
        object Label4: TLabel
          Left = 22
          Top = 16
          Width = 41
          Height = 14
          AutoSize = False
          Caption = 'Produto:'
        end
        object Label6: TLabel
          Left = 6
          Top = 40
          Width = 57
          Height = 14
          AutoSize = False
          Caption = 'Refer'#234'ncia:'
        end
        object Label7: TLabel
          Left = 20
          Top = 64
          Width = 42
          Height = 14
          AutoSize = False
          Caption = 'Unidade:'
        end
        object Label9: TLabel
          Left = 366
          Top = 63
          Width = 50
          Height = 14
          AutoSize = False
          Caption = 'Desconto:'
        end
        object edtCodIte: TEditFocus
          Tag = 99
          Left = 63
          Top = 7
          Width = 110
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 5
          TabOrder = 0
          OnExit = edtCodIteExit
          OnKeyPress = edtCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttAlfanumerico
        end
        object edtReferencia: TEditFocus
          Left = 63
          Top = 31
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
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
        object edtVlrDesIte: TEditFocus
          Tag = 99
          Left = 416
          Top = 55
          Width = 110
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          TabOrder = 4
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
        object edtDesUni: TEditFocus
          Left = 63
          Top = 55
          Width = 300
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
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
        object edtDesIte: TEditFocus
          Left = 174
          Top = 7
          Width = 501
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Enabled = False
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object btnCancelaItem: TBitBtnLocked
          Left = 565
          Top = 54
          Width = 110
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
        object btnAdicionar: TBitBtnLocked
          Left = 565
          Top = 30
          Width = 110
          Height = 22
          Caption = '&Adicionar'
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
      end
      object dbgItens: TDBGridCitel
        Left = 0
        Top = 82
        Width = 686
        Height = 137
        Align = alClient
        DataSource = dtsItens
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 1
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
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESITE'
            Title.Caption = 'Descri'#231#227'o do Produto'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VLRDES'
            Title.Alignment = taRightJustify
            Title.Caption = 'Desconto %'
            Width = 85
            Visible = True
          end>
      end
      object pnlResumo: TPanel
        Tag = 2
        Left = 0
        Top = 219
        Width = 686
        Height = 30
        Align = alBottom
        Color = 16770261
        TabOrder = 2
        object lblTotDesIte: TLabel
          Left = 400
          Top = 5
          Width = 85
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
    end
    object tbsGenerica: TTabSheet
      Caption = '&Gen'#233'rica'
      ImageIndex = 1
      object pnlResumo1: TPanel
        Tag = 2
        Left = 0
        Top = 219
        Width = 686
        Height = 30
        Align = alBottom
        Color = 16770261
        TabOrder = 2
        object lblTotDesGen: TLabel
          Left = 278
          Top = 5
          Width = 100
          Height = 14
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object dbgItens2: TDBGridCitel
        Left = 0
        Top = 93
        Width = 686
        Height = 126
        Align = alClient
        DataSource = dtsItens2
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect]
        ReadOnly = True
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnKeyDown = dbgItens2KeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Expanded = False
            FieldName = 'CODOPC'
            Title.Caption = 'C'#243'digo'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DESOPC'
            Title.Caption = 'Op'#231#227'o'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VLRDES'
            Title.Alignment = taRightJustify
            Title.Caption = '% Desconto'
            Width = 100
            Visible = True
          end>
      end
      object pnlGenerico: TPanel
        Left = 0
        Top = 0
        Width = 686
        Height = 93
        Align = alTop
        Color = 16770261
        TabOrder = 0
        object lblOpcao: TLabel
          Left = 64
          Top = 50
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Op'#231#227'o:'
        end
        object Label26: TLabel
          Left = 37
          Top = 73
          Width = 61
          Height = 14
          AutoSize = False
          Caption = '% Desconto:'
        end
        object Label20: TLabel
          Left = 64
          Top = 21
          Width = 36
          Height = 14
          AutoSize = False
          Caption = 'Op'#231#227'o:'
        end
        object edtCodOpc: TEditFocus
          Tag = 99
          Left = 99
          Top = 41
          Width = 100
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 1
          OnExit = edtCodOpcExit
          OnKeyPress = edtCodOpcKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtVlrDesGen: TEditFocus
          Tag = 99
          Left = 99
          Top = 65
          Width = 100
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          TabOrder = 3
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
        object edtDesOpc: TEditFocus
          Left = 199
          Top = 41
          Width = 364
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
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
        object rdgOpcao: TRadioGroup
          Left = 99
          Top = 2
          Width = 464
          Height = 36
          Columns = 3
          ItemIndex = 0
          Items.Strings = (
            '1 - Linha/Grupo'
            '2 - Fornecedor'
            '3 - Marca')
          TabOrder = 0
          OnClick = rdgOpcaoClick
        end
        object btnCancelaItem2: TBitBtnLocked
          Left = 566
          Top = 64
          Width = 110
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
          TabOrder = 5
          OnClick = btnCancelaItem2Click
        end
        object btnAdicionar2: TBitBtnLocked
          Left = 566
          Top = 40
          Width = 110
          Height = 22
          Caption = '&Adicionar'
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
          OnClick = btnAdicionar2Click
        end
      end
    end
  end
  object pnlDadosAdicionais: TPanel [4]
    Tag = 3
    Left = 0
    Top = 365
    Width = 694
    Height = 84
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    Visible = False
    object Label12: TLabel
      Left = 166
      Top = 17
      Width = 75
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Observa'#231#227'o 1:'
    end
    object Label13: TLabel
      Left = 166
      Top = 42
      Width = 75
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Observa'#231#227'o 2:'
    end
    object Label14: TLabel
      Left = 166
      Top = 64
      Width = 75
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Observa'#231'ao 3:'
    end
    object Label16: TLabel
      Left = 10
      Top = 18
      Width = 53
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data In'#237'cio:'
    end
    object Label17: TLabel
      Left = 10
      Top = 40
      Width = 53
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Data Fim:'
    end
    object edtObs1: TEditFocus
      Left = 243
      Top = 8
      Width = 440
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 60
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 6
      TipoTexto = ttAlfanumerico
    end
    object edtObs2: TEditFocus
      Tag = 99
      Left = 243
      Top = 32
      Width = 440
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 60
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtObs3: TEditFocus
      Tag = 99
      Left = 243
      Top = 56
      Width = 440
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 60
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 8
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 67
      Top = 8
      Width = 88
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 0
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 67
      Top = 32
      Width = 88
      Height = 22
      EditMask = '99/99/9999;1;_'
      MaxLength = 10
      TabOrder = 1
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited pnlStatus: TPanel
    Top = 477
    Width = 694
    ExplicitTop = 477
    ExplicitWidth = 694
    inherited pnlNomeForm: TPanel
      Left = 523
      ExplicitLeft = 523
    end
    inherited pnlInfo: TPanel
      Width = 523
      ExplicitWidth = 523
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 640
    Top = 16
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    OnDataChange = dtsItensDataChange
    Left = 641
    Top = 235
  end
  object cdsItens2: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'CODOPC'
    Params = <>
    StoreDefs = True
    Left = 612
    Top = 275
    object cdsItens2CODOPC: TStringField
      FieldName = 'CODOPC'
      Size = 10
    end
    object cdsItens2DESOPC: TStringField
      FieldName = 'DESOPC'
      Size = 100
    end
    object cdsItens2VLRDES: TFloatField
      FieldName = 'VLRDES'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItens2OPCAO: TStringField
      FieldName = 'OPCAO'
      Size = 1
    end
    object cdsItens2AUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsItens2AGG_TOTDES: TAggregateField
      FieldName = 'AGG_TOTDES'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(VLRDES)'
    end
  end
  object dtsItens2: TDataSource
    DataSet = cdsItens2
    OnDataChange = dtsItens2DataChange
    Left = 641
    Top = 275
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <>
    IndexFieldNames = 'CODITE'
    Params = <>
    StoreDefs = True
    AfterOpen = cdsItensAfterOpen
    Left = 611
    Top = 236
    object cdsItensCODITE: TStringField
      DisplayWidth = 7
      FieldName = 'CODITE'
      Size = 7
    end
    object cdsItensDESITE: TStringField
      FieldName = 'DESITE'
      Size = 150
    end
    object cdsItensITESIM: TStringField
      FieldName = 'ITESIM'
      Size = 6
    end
    object cdsItensAUTINC: TStringField
      FieldName = 'AUTINC'
    end
    object cdsItensVLRDES: TFloatField
      FieldName = 'VLRDES'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensAGG_TOTDES: TAggregateField
      Alignment = taRightJustify
      FieldName = 'AGG_TOTDES'
      Active = True
      DisplayName = ''
      DisplayFormat = '#,##0.00'
      Expression = 'SUM(VLRDES)'
    end
  end
end
