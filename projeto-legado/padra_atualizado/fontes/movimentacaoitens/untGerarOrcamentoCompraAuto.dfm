inherited frmGerarOrcamentoCompraAuto: TfrmGerarOrcamentoCompraAuto
  Width = 779
  Height = 552
  Caption = 'Gera'#231#227'o de Or'#231'amento de Compra Autom'#225'tico'
  Position = poScreenCenter
  ExplicitWidth = 779
  ExplicitHeight = 552
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 479
    Width = 773
    TabOrder = 1
    ExplicitTop = 479
    ExplicitWidth = 773
    inherited FlwBotoes: TFlowPanel
      Width = 692
      ExplicitWidth = 692
      object btnConfirmar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 118
        Height = 22
        Caption = '[F10] &Confirmar'
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
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 694
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 694
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 507
    Width = 773
    TabOrder = 2
    ExplicitTop = 507
    ExplicitWidth = 773
    inherited pnlNomeForm: TPanel
      Left = 602
      TabOrder = 1
      ExplicitLeft = 602
    end
    inherited pnlInfo: TPanel
      Width = 602
      TabOrder = 0
      ExplicitWidth = 602
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 773
    Height = 479
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object pnlLeft: TPanel
      Left = 1
      Top = 1
      Width = 771
      Height = 477
      Align = alClient
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 0
      object cxGroupBox4: TGroupBox
        Left = 3
        Top = 5
        Width = 757
        Height = 372
        Caption = 'Filtros para os Produtos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object Label9: TLabel
          Left = 6
          Top = 20
          Width = 59
          Height = 14
          Caption = 'Linha/Grupo'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label10: TLabel
          Left = 6
          Top = 59
          Width = 56
          Height = 14
          Caption = 'Fornecedor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 6
          Top = 96
          Width = 30
          Height = 14
          Caption = 'Marca'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label1: TLabel
          Left = 6
          Top = 249
          Width = 53
          Height = 14
          Caption = 'Refer'#234'ncia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 122
          Top = 249
          Width = 39
          Height = 14
          Caption = 'Unidade'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblEmpresa: TLabel
          Left = 6
          Top = 327
          Width = 42
          Height = 14
          Caption = 'Empresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label15: TLabel
          Left = 6
          Top = 134
          Width = 91
          Height = 14
          Caption = 'Grupo de Compras'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 6
          Top = 210
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Departamento:'
        end
        object Label13: TLabel
          Left = 6
          Top = 289
          Width = 79
          Height = 14
          Alignment = taRightJustify
          Caption = 'Acordo de Obj. :'
        end
        object Label3: TLabel
          Left = 6
          Top = 171
          Width = 91
          Height = 14
          Caption = 'Grupo de Produtos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object pnlRight: TPanel
          Left = 510
          Top = 16
          Width = 245
          Height = 354
          Align = alRight
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 10
          object chkInativoCompra: TCheckBox
            Left = 4
            Top = 232
            Width = 161
            Height = 17
            Hint = 'Incluir Inativos para Compra'
            Caption = 'Incluir Inativos para Compra'
            TabOrder = 4
          end
          object rdgStatus: TRadioGroup
            Left = 4
            Top = 190
            Width = 236
            Height = 34
            Caption = 'Status'
            Columns = 3
            ItemIndex = 2
            Items.Strings = (
              'Ativos'
              'Inativos'
              'Todos')
            TabOrder = 3
          end
          object rdgLocFis: TRadioGroup
            Left = 4
            Top = 126
            Width = 236
            Height = 56
            Caption = 'Localiza'#231#227'o F'#237'sica - Imprimir Produtos:'
            Columns = 2
            ItemIndex = 2
            Items.Strings = (
              'Com Localiza'#231#227'o'
              'Sem Localiza'#231#227'o'
              'Todos')
            TabOrder = 2
          end
          object rdgModCom: TRadioGroup
            Left = 4
            Top = 63
            Width = 236
            Height = 56
            Caption = 'Modalidade de compra'
            Columns = 2
            ItemIndex = 2
            Items.Strings = (
              'Centralizado'
              'N'#227'o Centralizado'
              'Todos')
            TabOrder = 1
          end
          object rdgSaldo: TRadioGroup
            Left = 4
            Top = 1
            Width = 236
            Height = 56
            Caption = 'Saldo Atual'
            Columns = 2
            ItemIndex = 3
            Items.Strings = (
              'Menor que zero'
              'Zero'
              'Maior que zero'
              'Todos')
            TabOrder = 0
          end
        end
        object mskLinGru: TMaskEditFocus
          Tag = 99
          Left = 3
          Top = 37
          Width = 57
          Height = 22
          EditMask = '999.999;0;_'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 7
          ParentFont = False
          TabOrder = 0
          Text = ''
          OnKeyPress = mskLinGruKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object edtDesGru: TEditFocus
          Left = 64
          Top = 34
          Width = 447
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 11
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodFor: TEditFocus
          Tag = 99
          Left = 6
          Top = 73
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ParentFont = False
          TabOrder = 1
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
        object edtDesFor: TEditFocus
          Left = 64
          Top = 73
          Width = 447
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 12
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodMar: TEditFocus
          Tag = 99
          Left = 6
          Top = 110
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 6
          ParentFont = False
          TabOrder = 2
          OnExit = edtCodMarExit
          OnKeyPress = edtCodMarKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 6
          TipoTexto = ttNumerico
        end
        object edtDesMar: TEditFocus
          Left = 64
          Top = 110
          Width = 447
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 13
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtRefere: TEditFocus
          Tag = 99
          Left = 6
          Top = 263
          Width = 114
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodUni: TEditFocus
          Tag = 99
          Left = 121
          Top = 263
          Width = 22
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 7
          OnKeyPress = edtCodUniKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodEmp: TEditFocus
          Tag = 99
          Left = 6
          Top = 341
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentFont = False
          TabOrder = 9
          OnExit = edtCodEmpExit
          OnKeyPress = edtCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesEmp: TEditFocus
          Left = 64
          Top = 341
          Width = 447
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 14
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
          Left = 6
          Top = 148
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 3
          OnExit = edtCodCmpExit
          OnKeyPress = edtCodCmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesCmp: TEditFocus
          Left = 64
          Top = 148
          Width = 447
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 15
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtSigUni: TEditFocus
          Tag = 99
          Left = 143
          Top = 263
          Width = 38
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 16
          OnKeyPress = edtCodUniKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtDesUni: TEditFocus
          Tag = 99
          Left = 181
          Top = 263
          Width = 330
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Color = 16768952
          Enabled = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentFont = False
          TabOrder = 17
          OnKeyPress = edtCodUniKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodDep: TEditFocus
          Tag = 99
          Left = 6
          Top = 224
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          TabOrder = 5
          OnExit = edtCodDepExit
          OnKeyPress = edtCodDepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesCodDep: TEditFocus
          Left = 64
          Top = 224
          Width = 447
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 18
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtAcoObj: TEditFocus
          Tag = 99
          Left = 6
          Top = 304
          Width = 296
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 20
          TabOrder = 8
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 20
          TipoTexto = ttAlfanumerico
        end
        object edtPrdGru: TEditFocus
          Tag = 99
          Left = 6
          Top = 186
          Width = 57
          Height = 22
          Alignment = taLeftJustify
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ParentFont = False
          TabOrder = 4
          OnExit = edtPrdGruExit
          OnKeyPress = edtPrdGruKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesPrdPro: TEditFocus
          Left = 64
          Top = 186
          Width = 447
          Height = 22
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 19
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
      end
      object cxGroupBox1: TGroupBox
        Left = 3
        Top = 385
        Width = 757
        Height = 85
        Caption = 'C'#225'lculo da Quantidade de Sugest'#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object chkMulCom: TCheckBox
          Left = 463
          Top = 26
          Width = 169
          Height = 17
          Caption = 'Considerar m'#250'ltiplo de compra'
          TabOrder = 2
        end
        object rdgPedCom: TRadioGroup
          Left = 14
          Top = 20
          Width = 242
          Height = 56
          Caption = 'Considerar Pedido e Or'#231'amento de Compra:'
          Columns = 2
          ItemIndex = 0
          Items.Strings = (
            'Sim'
            'N'#227'o'
            'Apenas Pedido'
            'Apenas Or'#231'amento')
          TabOrder = 0
        end
        object rdgMimMax: TRadioGroup
          Left = 263
          Top = 20
          Width = 185
          Height = 56
          Caption = 'Calcular pelo estoque:'
          ItemIndex = 0
          Items.Strings = (
            'M'#237'nimo'
            'M'#225'ximo')
          TabOrder = 1
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1022
    Top = 110
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 994
    Top = 116
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 392
    Top = 104
  end
end
