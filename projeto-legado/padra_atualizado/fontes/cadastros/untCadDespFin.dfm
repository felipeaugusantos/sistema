inherited frmCadDespFin: TfrmCadDespFin
  Width = 545
  Height = 487
  Caption = 'Cadastro de Despesas Financeiras'
  ExplicitWidth = 545
  ExplicitHeight = 487
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 414
    Width = 539
    ExplicitTop = 414
    ExplicitWidth = 539
    inherited FlwBotoes: TFlowPanel
      Width = 535
      ExplicitTop = 2
      ExplicitWidth = 535
    end
    inherited btnSair: TBitBtnLocked
      Left = 456
      Top = 4
      Height = 20
      ExplicitLeft = 456
      ExplicitTop = 4
      ExplicitHeight = 20
    end
  end
  inherited pnlStatus: TPanel
    Top = 442
    Width = 539
    ExplicitTop = 442
    ExplicitWidth = 539
    inherited pnlNomeForm: TPanel
      Left = 192
      ExplicitLeft = 192
    end
    inherited pnlInfo: TPanel
      Width = 192
      ExplicitWidth = 192
    end
  end
  inherited pgcDados: TPageControl
    Width = 539
    Height = 414
    OnChange = pgcDadosChange
    ExplicitWidth = 539
    ExplicitHeight = 414
    inherited tbsGeral: TTabSheet
      Caption = 'Cadastro'
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 531
      ExplicitHeight = 382
      object pnlDados: TPanel
        Left = 0
        Top = 0
        Width = 531
        Height = 382
        Align = alClient
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 16
          Top = 85
          Width = 47
          Height = 14
          Caption = 'C'#243'd. Item:'
        end
        object Label5: TLabel
          Left = 16
          Top = 8
          Width = 73
          Height = 14
          Caption = 'Data Opera'#231#227'o'
        end
        object Label3: TLabel
          Left = 274
          Top = 162
          Width = 79
          Height = 14
          Caption = 'Valor Opera'#231#227'o:'
        end
        object lblCliFor: TLabel
          Left = 60
          Top = 46
          Width = 35
          Height = 14
          Caption = 'Cliente:'
        end
        object Label15: TLabel
          Left = 16
          Top = 162
          Width = 96
          Height = 14
          Caption = 'C'#243'd. Cont. Anal'#237'tica:'
        end
        object Label16: TLabel
          Left = 16
          Top = 123
          Width = 78
          Height = 14
          Caption = 'Plano de Contas'
        end
        object Label18: TLabel
          Left = 16
          Top = 340
          Width = 175
          Height = 14
          Caption = 'Descri'#231#227'o do Documento/Opera'#231#227'o:'
        end
        object Label13: TLabel
          Left = 92
          Top = 8
          Width = 74
          Height = 14
          Caption = 'C'#243'd. Bas. Calc.'
        end
        object Label14: TLabel
          Left = 16
          Top = 46
          Width = 39
          Height = 14
          Caption = 'Tipo F/C'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object edtCodIte: TDBEditFocus
          Tag = 99
          Left = 16
          Top = 99
          Width = 84
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DEF_CODITE'
          DataSource = dtsTabela
          MaxLength = 5
          TabOrder = 5
          OnExit = edtCodIteExit
          OnKeyPress = edtCodIteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtValOpe: TDBEditFocus
          Left = 274
          Top = 176
          Width = 121
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DEF_VALOPE'
          DataSource = dtsTabela
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object gpbDadosPis: TGroupBox
          Left = 17
          Top = 204
          Width = 505
          Height = 62
          Caption = 'Pis'
          TabOrder = 9
          object Label4: TLabel
            Left = 8
            Top = 16
            Width = 22
            Height = 14
            Caption = 'CST:'
          end
          object Label6: TLabel
            Left = 61
            Top = 16
            Width = 28
            Height = 14
            Caption = 'Base:'
          end
          object Label7: TLabel
            Left = 188
            Top = 16
            Width = 42
            Height = 14
            Caption = 'Al'#237'quota:'
          end
          object Label8: TLabel
            Left = 257
            Top = 16
            Width = 28
            Height = 14
            Caption = 'Valor:'
          end
          object edtCstPis: TDBEditFocus
            Tag = 99
            Left = 8
            Top = 32
            Width = 47
            Height = 22
            CharCase = ecUpperCase
            DataField = 'DEF_CSTPIS'
            DataSource = dtsTabela
            MaxLength = 2
            TabOrder = 0
            OnKeyPress = edtCstPisKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtBasPis: TDBEditFocus
            Tag = 99
            Left = 61
            Top = 32
            Width = 121
            Height = 22
            CharCase = ecUpperCase
            DataField = 'DEF_BASPIS'
            DataSource = dtsTabela
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtAlqPis: TDBEditFocus
            Tag = 99
            Left = 188
            Top = 32
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'DEF_ALQPIS'
            DataSource = dtsTabela
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtValPis: TDBEditFocus
            Tag = 99
            Left = 257
            Top = 32
            Width = 121
            Height = 22
            CharCase = ecUpperCase
            DataField = 'DEF_VALPIS'
            DataSource = dtsTabela
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object edtCodigoParticipante: TDBEditFocus
          Tag = 99
          Left = 60
          Top = 60
          Width = 84
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DEF_CODPAR'
          DataSource = dtsTabela
          Enabled = False
          MaxLength = 8
          TabOrder = 4
          OnExit = edtCodigoParticipanteExit
          OnKeyPress = edtCodigoParticipanteKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object gpbDadosCofins: TGroupBox
          Left = 17
          Top = 272
          Width = 505
          Height = 62
          Caption = 'Cofins'
          TabOrder = 10
          object Label9: TLabel
            Left = 8
            Top = 16
            Width = 22
            Height = 14
            Caption = 'CST:'
          end
          object Label10: TLabel
            Left = 61
            Top = 16
            Width = 28
            Height = 14
            Caption = 'Base:'
          end
          object Label11: TLabel
            Left = 188
            Top = 16
            Width = 42
            Height = 14
            Caption = 'Al'#237'quota:'
          end
          object Label12: TLabel
            Left = 257
            Top = 16
            Width = 28
            Height = 14
            Caption = 'Valor:'
          end
          object edtCstCof: TDBEditFocus
            Tag = 99
            Left = 8
            Top = 32
            Width = 47
            Height = 22
            CharCase = ecUpperCase
            DataField = 'DEF_CSTCOF'
            DataSource = dtsTabela
            MaxLength = 2
            TabOrder = 0
            OnKeyPress = edtCstCofKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TipoTexto = ttAlfanumerico
          end
          object edtBasCof: TDBEditFocus
            Tag = 99
            Left = 61
            Top = 32
            Width = 121
            Height = 22
            CharCase = ecUpperCase
            DataField = 'DEF_BASCOF'
            DataSource = dtsTabela
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtAlqCof: TDBEditFocus
            Tag = 99
            Left = 188
            Top = 32
            Width = 63
            Height = 22
            CharCase = ecUpperCase
            DataField = 'DEF_ALQCOF'
            DataSource = dtsTabela
            TabOrder = 2
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object edtValCof: TDBEditFocus
            Tag = 99
            Left = 257
            Top = 32
            Width = 121
            Height = 22
            CharCase = ecUpperCase
            DataField = 'DEF_VALCOF'
            DataSource = dtsTabela
            TabOrder = 3
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object edtCodContAna: TDBEditFocus
          Tag = 99
          Left = 16
          Top = 176
          Width = 252
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DEF_CODCCA'
          DataSource = dtsTabela
          MaxLength = 60
          TabOrder = 7
          OnKeyPress = edtCodContAnaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtCodCC: TDBEditFocus
          Tag = 99
          Left = 16
          Top = 137
          Width = 84
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DEF_CODCTA'
          DataSource = dtsTabela
          MaxLength = 7
          TabOrder = 6
          OnExit = edtCodCCExit
          OnKeyPress = edtCodCCKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
        object edtDesDocOpe: TDBEditFocus
          Left = 16
          Top = 354
          Width = 505
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DEF_OBSDOP'
          DataSource = dtsTabela
          TabOrder = 11
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object rgIndicadorOrigemCredito: TRadioGroup
          Left = 178
          Top = 6
          Width = 343
          Height = 41
          Caption = 'Indicador da origem do cr'#233'dito:'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Opera'#231#227'o no Mercado Interno'
            'Opera'#231#227'o de Importa'#231#227'o')
          TabOrder = 2
        end
        object edtCodBasCalcCredito: TDBEditFocus
          Tag = 99
          Left = 92
          Top = 22
          Width = 77
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DEF_CBCCRE'
          DataSource = dtsTabela
          MaxLength = 2
          TabOrder = 1
          OnKeyPress = edtCodBasCalcCreditoKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtNomeParticipante: TEditFocus
          Left = 146
          Top = 60
          Width = 375
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        object edtDesIte: TEditFocus
          Left = 102
          Top = 99
          Width = 419
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 13
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesCC: TEditFocus
          Left = 102
          Top = 137
          Width = 419
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 14
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtTipFc: TDBEditFocus
          Tag = 99
          Left = 17
          Top = 60
          Width = 40
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DEF_TIP_FC'
          DataSource = dtsTabela
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object edtDtaOpe: TDBEditFocus
          Tag = 99
          Left = 16
          Top = 22
          Width = 70
          Height = 22
          CharCase = ecUpperCase
          DataField = 'DEF_DTAOPE'
          DataSource = dtsTabela
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
      end
    end
    object tsDocumento: TTabSheet
      Caption = 'Documento'
      ImageIndex = 1
      object rgIndOrigem: TRadioGroup
        Left = 39
        Top = 19
        Width = 177
        Height = 43
        Caption = 'Indicador da origem do cr'#233'dito: '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          '0'
          '1')
        TabOrder = 0
      end
      object GroupBox1: TGroupBox
        Left = 39
        Top = 73
        Width = 177
        Height = 62
        Caption = 'Pis'
        TabOrder = 2
        object Label17: TLabel
          Left = 12
          Top = 16
          Width = 22
          Height = 14
          Caption = 'CST:'
        end
        object Label20: TLabel
          Left = 72
          Top = 16
          Width = 42
          Height = 14
          Caption = 'Al'#237'quota:'
        end
        object edtCstPisD: TEditFocus
          Left = 12
          Top = 32
          Width = 47
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAlqPisD: TEditFocus
          Left = 72
          Top = 32
          Width = 63
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
          TipoTexto = ttNumerico
        end
      end
      object GroupBox2: TGroupBox
        Left = 234
        Top = 73
        Width = 252
        Height = 62
        Caption = 'Cofins'
        TabOrder = 3
        object Label22: TLabel
          Left = 13
          Top = 16
          Width = 22
          Height = 14
          Caption = 'CST:'
        end
        object Label24: TLabel
          Left = 73
          Top = 16
          Width = 42
          Height = 14
          Caption = 'Al'#237'quota:'
        end
        object edtAlqCofD: TEditFocus
          Left = 73
          Top = 32
          Width = 63
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
          TipoTexto = ttNumerico
        end
        object edtCstCofD: TEditFocus
          Left = 13
          Top = 32
          Width = 47
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
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
      object rgTipoOperacao: TRadioGroup
        Left = 234
        Top = 19
        Width = 252
        Height = 43
        Caption = 'Tipo Opera'#231#227'o :'
        Columns = 3
        ItemIndex = 0
        Items.Strings = (
          '0'
          '1'
          '2')
        TabOrder = 1
        Visible = False
      end
      object btnGravarDocumentos: TBitBtnLocked
        Left = 414
        Top = 224
        Width = 72
        Height = 20
        Caption = '&Gravar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
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
        ParentFont = False
        TabOrder = 7
        OnClick = btnGravarDocumentosClick
      end
      object GroupBox3: TGroupBox
        Left = 39
        Top = 146
        Width = 177
        Height = 72
        Caption = 'Per'#237'odo'
        TabOrder = 4
        object Label1: TLabel
          Left = 12
          Top = 19
          Width = 51
          Height = 14
          Caption = 'Data inicial'
        end
        object Label19: TLabel
          Left = 91
          Top = 19
          Width = 45
          Height = 14
          Caption = 'Data final'
        end
        object mskDtaIni: TcxMaskEdit
          Left = 12
          Top = 37
          Properties.EditMask = '99/99/9999;1;_'
          TabOrder = 0
          Text = '  /  /    '
          OnKeyDown = mskDtaIniKeyDown
          Width = 73
        end
        object mskDtaFin: TcxMaskEdit
          Left = 91
          Top = 37
          Properties.EditMask = '99/99/9999;1;_'
          TabOrder = 1
          Text = '  /  /    '
          OnKeyDown = mskDtaFinKeyDown
          Width = 73
        end
      end
      object GroupBox4: TGroupBox
        Left = 234
        Top = 146
        Width = 252
        Height = 72
        Caption = 'Cofins'
        TabOrder = 5
        object Label21: TLabel
          Left = 13
          Top = 19
          Width = 96
          Height = 14
          Caption = 'C'#243'd. Cont. Anal'#237'tica:'
        end
        object edtCodCca: TEditFocus
          Tag = 99
          Left = 13
          Top = 37
          Width = 228
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          MaxLength = 60
          TabOrder = 0
          OnKeyPress = edtCodCcaKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object btnExcluirDoc: TBitBtnLocked
        Left = 336
        Top = 224
        Width = 72
        Height = 20
        Caption = '&Excluir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpFixed
        Font.Style = []
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
        ParentFont = False
        TabOrder = 6
        OnClick = btnExcluirDocClick
      end
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 768
    Top = 24
  end
  object dtsTabela: TDataSource
    OnStateChange = dtsTabelaStateChange
    Left = 424
    Top = 10
  end
end
