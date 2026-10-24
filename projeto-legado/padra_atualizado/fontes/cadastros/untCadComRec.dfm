inherited frmCadComRec: TfrmCadComRec
  Left = 244
  Top = 135
  Width = 656
  Height = 511
  Caption = 'Faixa de recebimento para comiss'#227'o de vendedores'
  OnDestroy = FormDestroy
  ExplicitWidth = 656
  ExplicitHeight = 511
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 441
    Width = 650
    Height = 25
    ExplicitTop = 441
    ExplicitWidth = 650
    ExplicitHeight = 25
    object Bevel1: TBevel [0]
      Left = 463
      Top = 5
      Width = 2
      Height = 18
    end
    object Bevel2: TBevel [1]
      Left = 569
      Top = 5
      Width = 2
      Height = 18
    end
    inherited FlwBotoes: TFlowPanel
      Width = 568
      Height = 21
      ExplicitTop = 2
      ExplicitWidth = 568
      ExplicitHeight = 21
      inherited btnIncluir: TBitBtnLocked
        Width = 76
        ExplicitWidth = 76
      end
      inherited btnGravar: TBitBtnLocked
        Left = 76
        Width = 76
        ExplicitLeft = 76
        ExplicitWidth = 76
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 152
        Width = 76
        ExplicitLeft = 152
        ExplicitWidth = 76
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 228
        Width = 76
        ExplicitLeft = 228
        ExplicitWidth = 76
      end
      inherited btnCancela: TBitBtnLocked
        Left = 304
        Width = 77
        ExplicitLeft = 304
        ExplicitWidth = 77
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 381
        Width = 77
        ExplicitLeft = 381
        ExplicitWidth = 77
      end
      object btnHeranca: TBitBtnLocked
        Left = 458
        Top = 0
        Width = 101
        Height = 20
        Caption = '&Heran'#231'a de Faixa'
        Enabled = False
        TabOrder = 6
        OnClick = btnHerancaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 570
      Width = 78
      Height = 21
      Align = alRight
      ExplicitLeft = 570
      ExplicitWidth = 78
      ExplicitHeight = 21
    end
  end
  inherited pgcDados: TPageControl
    Width = 650
    Height = 441
    ExplicitWidth = 650
    ExplicitHeight = 441
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 642
      ExplicitHeight = 409
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 650
    Height = 441
    Align = alClient
    Color = 16770261
    TabOrder = 3
    object pnlGrid: TPanel
      Left = 1
      Top = 182
      Width = 648
      Height = 258
      Align = alClient
      Color = 16770261
      TabOrder = 1
      object Label12: TLabel
        Left = 5
        Top = 321
        Width = 228
        Height = 14
        Caption = 'Pressione [DEL] para remover registros do Grid'
      end
      object dbgDados: TDBGridCitel
        Left = 1
        Top = 1
        Width = 646
        Height = 235
        Align = alClient
        DataSource = dtsDados
        Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = 14
        TitleFont.Name = 'Arial'
        TitleFont.Pitch = fpVariable
        TitleFont.Style = []
        OnDblClick = dbgDadosDblClick
        OnKeyDown = dbgDadosKeyDown
        CorZebra = clMoneyGreen
        Zebra = False
        DestacarMouse = False
        Columns = <
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_RECINI'
            Title.Alignment = taRightJustify
            Title.Caption = 'Recebimento Inicial'
            Width = 224
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_RECFIN'
            Title.Alignment = taRightJustify
            Title.Caption = 'Recebimento Final'
            Width = 230
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'COM_PERCOM'
            Title.Alignment = taRightJustify
            Title.Caption = '% Comiss'#227'o'
            Width = 150
            Visible = True
          end>
      end
      object pnlLegenda: TPanel
        Left = 1
        Top = 236
        Width = 646
        Height = 21
        Align = alBottom
        TabOrder = 1
        object Label3: TLabel
          Left = 8
          Top = 3
          Width = 264
          Height = 14
          Caption = 'Pressione [DEL] para remover registros do Grid'
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
    object pnlDados: TPanel
      Left = 1
      Top = 1
      Width = 648
      Height = 181
      Align = alTop
      Color = 16770261
      TabOrder = 0
      object pnlCentro: TPanel
        Left = 1
        Top = 130
        Width = 646
        Height = 50
        Align = alClient
        Color = 16770261
        TabOrder = 2
        object Label5: TLabel
          Left = 8
          Top = 4
          Width = 91
          Height = 14
          Caption = 'Recebimento Inicial'
        end
        object Label6: TLabel
          Left = 195
          Top = 4
          Width = 87
          Height = 14
          Caption = 'Recebimento Final'
        end
        object Label7: TLabel
          Left = 381
          Top = 4
          Width = 60
          Height = 14
          Caption = '% Comiss'#227'o'
        end
        object edtRecIni: TEditFocus
          Tag = 99
          Left = 6
          Top = 21
          Width = 185
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          TabOrder = 0
          Text = '0,000'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtRecFin: TEditFocus
          Tag = 99
          Left = 193
          Top = 21
          Width = 185
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
          TabOrder = 1
          Text = '0,000'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttNumerico
          EditFormat = '#,##0.00'
        end
        object edtPerCom: TEditFocus
          Tag = 99
          Left = 379
          Top = 21
          Width = 133
          Height = 22
          Alignment = taRightJustify
          CharCase = ecUpperCase
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
        object btnAdicionar: TBitBtnLocked
          Left = 516
          Top = 20
          Width = 116
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
          OnClick = btnAdicionarClick
        end
      end
      object pnlTopo: TPanel
        Left = 1
        Top = 1
        Width = 646
        Height = 95
        Align = alTop
        Color = 16770261
        TabOrder = 0
        object Label1: TLabel
          Left = 56
          Top = 13
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'C'#243'digo:'
        end
        object Label2: TLabel
          Left = 162
          Top = 13
          Width = 52
          Height = 14
          Caption = 'Descri'#231#227'o:'
        end
        object Label24: TLabel
          Left = 5
          Top = 40
          Width = 87
          Height = 14
          Alignment = taRightJustify
          Caption = 'Tipo de Operador:'
        end
        object lblCodDep: TLabel
          Left = 22
          Top = 69
          Width = 70
          Height = 14
          Alignment = taRightJustify
          Caption = 'Departamento:'
        end
        object dbeCodRec: TDBEditFocus
          Tag = 99
          Left = 94
          Top = 8
          Width = 57
          Height = 22
          CharCase = ecUpperCase
          DataField = 'COM_CODTAB'
          DataSource = dtsComRec
          TabOrder = 0
          OnExit = dbeCodRecExit
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttNumerico
        end
        object dbeDescricao: TDBEditFocus
          Tag = 99
          Left = 217
          Top = 8
          Width = 415
          Height = 22
          CharCase = ecUpperCase
          DataField = 'COM_DESCRI'
          DataSource = dtsComRec
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TipoTexto = ttAlfanumerico
        end
        object cbbTipOpe: TComboBoxFocus
          Tag = 99
          Left = 94
          Top = 36
          Width = 538
          Height = 22
          Style = csDropDownList
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 2
          Items.Strings = (
            'Digitador'
            'Vendedor Interno'
            'Representante Externo Loja'
            'Representante Externo Distribuidor'
            'Sub-Gerente'
            'Gerente'
            'Compras')
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
        end
        object dbeCodDep: TDBEditFocus
          Tag = 99
          Left = 94
          Top = 65
          Width = 57
          Height = 22
          CharCase = ecUpperCase
          DataField = 'COM_CODDEP'
          DataSource = dtsComRec
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          TabOrder = 3
          OnKeyPress = dbeCodDepKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          PanelInfo = pnlInfo
          TipoTexto = ttNumerico
        end
        object edtDesDep: TEditFocus
          Left = 152
          Top = 65
          Width = 480
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      end
      object pnlEmpresa: TPanel
        Left = 1
        Top = 96
        Width = 646
        Height = 34
        Align = alTop
        Color = 16770261
        TabOrder = 1
        object Label11: TLabel
          Left = 47
          Top = 9
          Width = 45
          Height = 14
          Alignment = taRightJustify
          Caption = 'Empresa:'
        end
        object edtNomEmp: TEditFocus
          Left = 153
          Top = 6
          Width = 479
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
        object edtCodEmp: TDBEditFocus
          Tag = 99
          Left = 94
          Top = 6
          Width = 57
          Height = 22
          CharCase = ecUpperCase
          DataField = 'COM_CODEMP'
          DataSource = dtsComRec
          MaxLength = 3
          TabOrder = 0
          OnExit = edtCodEmpExit
          OnKeyPress = edtCodEmpKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TipoTexto = ttAlfanumerico
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 466
    Width = 650
    ExplicitTop = 466
    ExplicitWidth = 650
    inherited pnlNomeForm: TPanel
      Left = 518
      Width = 132
      ExplicitLeft = 518
      ExplicitWidth = 132
    end
    inherited pnlInfo: TPanel
      Width = 518
      ExplicitWidth = 518
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 832
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 800
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 592
    Top = 280
  end
  object dtsComRec: TDataSource
    OnStateChange = dtsComRecStateChange
    Left = 592
    Top = 200
  end
  object dtsDados: TDataSource
    Left = 593
    Top = 232
  end
end
