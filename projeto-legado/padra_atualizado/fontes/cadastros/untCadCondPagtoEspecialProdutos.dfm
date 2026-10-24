inherited frmCadCondPagtoEspecialProdutos: TfrmCadCondPagtoEspecialProdutos
  Width = 1108
  Height = 779
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Cadastro de Condi'#231#227'o de Pagamento Especial x Produtos'
  OnResize = FormResize
  ExplicitWidth = 1108
  ExplicitHeight = 779
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 704
    Width = 1102
    Height = 30
    ExplicitTop = 704
    ExplicitWidth = 1102
    ExplicitHeight = 30
    inherited FlwBotoes: TFlowPanel
      Width = 1098
      Height = 26
      ExplicitTop = 2
      ExplicitWidth = 1098
      ExplicitHeight = 26
      inherited btnIncluir: TBitBtnLocked
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      inherited btnGravar: TBitBtnLocked
        Left = 78
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitLeft = 78
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      inherited btnAlterar: TBitBtnLocked
        Left = 156
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitLeft = 156
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      inherited btnExcluir: TBitBtnLocked
        Left = 234
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitLeft = 234
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      inherited btnCancela: TBitBtnLocked
        Left = 312
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitLeft = 312
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
      inherited btnPesquisa: TBitBtnLocked
        Left = 390
        Width = 78
        Height = 25
        Align = alLeft
        ExplicitLeft = 390
        ExplicitWidth = 78
        ExplicitHeight = 25
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1021
      Width = 78
      Height = 25
      ExplicitLeft = 1021
      ExplicitWidth = 78
      ExplicitHeight = 25
    end
  end
  inherited pnlStatus: TPanel
    Top = 734
    Width = 1102
    ExplicitTop = 734
    ExplicitWidth = 1102
    inherited pnlNomeForm: TPanel
      Left = 755
      ExplicitLeft = 755
    end
    inherited pnlInfo: TPanel
      Width = 755
      ExplicitWidth = 755
    end
  end
  inherited pgcDados: TPageControl
    Width = 1102
    Height = 704
    ExplicitWidth = 1102
    ExplicitHeight = 704
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1094
      ExplicitHeight = 672
      object pnlEmpresa: TPanel
        Left = 758
        Top = 0
        Width = 336
        Height = 672
        Align = alRight
        Alignment = taRightJustify
        ParentColor = True
        TabOrder = 0
        object Label16: TLabel
          Left = 1
          Top = 1
          Width = 334
          Height = 14
          Align = alTop
          Alignment = taCenter
          Caption = 'Empresas'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 56
        end
        object clbEmpresa: TCheckListBox
          Left = 1
          Top = 15
          Width = 334
          Height = 656
          Align = alClient
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemHeight = 14
          TabOrder = 0
        end
      end
      object pnlprin: TPanel
        Left = 0
        Top = 0
        Width = 758
        Height = 672
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 758
          Height = 49
          Align = alTop
          Caption = 'Dados:.'
          TabOrder = 0
          object Label1: TLabel
            Left = 4
            Top = 24
            Width = 39
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'digo:'
          end
          object Label2: TLabel
            Left = 525
            Top = 24
            Width = 46
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Validade:'
          end
          object Label3: TLabel
            Left = 653
            Top = 24
            Width = 6
            Height = 14
            Alignment = taRightJustify
            Caption = 'a'
          end
          object dbeCodCes: TDBEditFocus
            Tag = 99
            Left = 49
            Top = 18
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CES_CODIGO'
            DataSource = dtsCondPagEsp
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesCes: TDBEditFocus
            Tag = 99
            Left = 121
            Top = 18
            Width = 392
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CES_DESCRI'
            DataSource = dtsCondPagEsp
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtaIni: TDBEditFocus
            Tag = 99
            Left = 577
            Top = 18
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CES_DTAINI'
            DataSource = dtsCondPagEsp
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 2
            OnEnter = dbeDtaIniEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDtaFim: TDBEditFocus
            Tag = 99
            Left = 665
            Top = 18
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'CES_DTAFIM'
            DataSource = dtsCondPagEsp
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            OnEnter = dbeDtaFimEnter
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlGrid: TPanel
          Left = 0
          Top = 135
          Width = 758
          Height = 537
          Align = alClient
          Alignment = taRightJustify
          ParentColor = True
          TabOrder = 2
          object cxgItens: TcxGridCitel
            Left = 1
            Top = 1
            Width = 756
            Height = 535
            Align = alClient
            TabOrder = 0
            LookAndFeel.Kind = lfUltraFlat
            LookAndFeel.NativeStyle = False
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgItensTableView: TcxGridDBBandedTableViewCitel
              OnKeyDown = cxgItensTableViewKeyDown
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsCadCes
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsData.Deleting = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              Bands = <
                item
                  Caption = 'Produto'
                  FixedKind = fkLeft
                end
                item
                end
                item
                  Caption = 'Valores do cadastro de produtos'
                end>
              Zebra = True
              Destaque = False
              DestacarRegistro = False
              CorZebra = clMoneyGreen
              object cxgItensICE_CODITE: TcxGridDBBandedColumn
                Caption = 'C'#243'd. item'
                DataBinding.FieldName = 'ICE_CODITE'
                Width = 70
                Position.BandIndex = 0
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxgItensITE_CODFAB: TcxGridDBBandedColumn
                Caption = 'C'#243'd. Fab'
                DataBinding.FieldName = 'ITE_CODFAB'
                Width = 70
                Position.BandIndex = 0
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxgItensITE_DESITE: TcxGridDBBandedColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'ITE_DESITE'
                Width = 282
                Position.BandIndex = 0
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object cxgItensUNI_SIGUNI: TcxGridDBBandedColumn
                Caption = 'Un'
                DataBinding.FieldName = 'UNI_SIGUNI'
                Width = 60
                Position.BandIndex = 1
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxgItensMAR_DESMAR: TcxGridDBBandedColumn
                Caption = 'Marca'
                DataBinding.FieldName = 'MAR_DESMAR'
                Width = 120
                Position.BandIndex = 1
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxgItensITE_SALDOS: TcxGridDBBandedColumn
                AlternateCaption = 'Saldo F'#237'sico'
                Caption = 'Saldo Fisico'
                DataBinding.FieldName = 'ITE_SALFIS'
                Width = 74
                Position.BandIndex = 1
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object cxgItensITE_SALDIS: TcxGridDBBandedColumn
                Caption = 'Saldo Dispon'#237'vel'
                DataBinding.FieldName = 'ITE_SALDIS'
                Width = 104
                Position.BandIndex = 1
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
              object cxgItensITE_PRECUS: TcxGridDBBandedColumn
                Caption = 'Pr. custo'
                DataBinding.FieldName = 'ITE_PRECUS'
                Width = 80
                Position.BandIndex = 2
                Position.ColIndex = 0
                Position.RowIndex = 0
              end
              object cxgItensITE_PREMED: TcxGridDBBandedColumn
                Caption = 'Pre'#231'o M'#233'dio'
                DataBinding.FieldName = 'ITE_PREMED'
                Width = 74
                Position.BandIndex = 2
                Position.ColIndex = 1
                Position.RowIndex = 0
              end
              object cxgItensITE_PREULT: TcxGridDBBandedColumn
                Caption = 'Pre'#231'o '#218'lt.Compra'
                DataBinding.FieldName = 'ITE_PREULT'
                Width = 103
                Position.BandIndex = 2
                Position.ColIndex = 2
                Position.RowIndex = 0
              end
              object cxgItensITE_IMPULT: TcxGridDBBandedColumn
                Caption = 'Pre'#231'o '#218'lt.Compra+Imp.'
                DataBinding.FieldName = 'ITE_IMPULT'
                Width = 138
                Position.BandIndex = 2
                Position.ColIndex = 3
                Position.RowIndex = 0
              end
            end
            object cxgItenslevel: TcxGridLevel
              GridView = cxgItensTableView
            end
          end
        end
        object pnlFiltrosProd: TPanel
          Left = 0
          Top = 49
          Width = 758
          Height = 86
          Align = alTop
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object Label12: TLabel
            Left = 402
            Top = 36
            Width = 42
            Height = 14
            Alignment = taRightJustify
            Caption = 'Unidade:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label4: TLabel
            Left = 404
            Top = 9
            Width = 40
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Produto:'
          end
          object Label9: TLabel
            Left = 5
            Top = 10
            Width = 68
            Height = 14
            Alignment = taRightJustify
            Caption = 'Linha / Grupo:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label11: TLabel
            Left = 41
            Top = 35
            Width = 33
            Height = 14
            Alignment = taRightJustify
            Caption = 'Marca:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object Label10: TLabel
            Left = 14
            Top = 59
            Width = 59
            Height = 14
            Alignment = taRightJustify
            Caption = 'Fornecedor:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ParentFont = False
          end
          object edtUnidade: TEditFocus
            Tag = 99
            Left = 449
            Top = 32
            Width = 70
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
            TabOrder = 8
            OnExit = edtUnidadeExit
            OnKeyPress = edtUnidadeKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtCodIte: TEditFocus
            Tag = 99
            Left = 449
            Top = 6
            Width = 70
            Height = 22
            Alignment = taLeftJustify
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = []
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            MaxLength = 5
            ParentFont = False
            TabOrder = 6
            OnEnter = edtCodIteEnter
            OnExit = edtCodIteExit
            OnKeyPress = edtCodIteKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 5
            TipoTexto = ttNumerico
          end
          object edtDesIte: TEditFocus
            Tag = 99
            Left = 521
            Top = 6
            Width = 230
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
          object edtDesGrupo: TEditFocus
            Tag = 99
            Left = 148
            Top = 6
            Width = 230
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object mskLinhaGrupo: TMaskEditFocus
            Tag = 99
            Left = 76
            Top = 6
            Width = 70
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
            OnExit = mskLinhaGrupoExit
            OnKeyPress = mskLinhaGrupoKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            ValidaData = False
          end
          object edtMarca: TEditFocus
            Tag = 99
            Left = 76
            Top = 31
            Width = 70
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
            OnExit = edtMarcaExit
            OnKeyPress = edtMarcaKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 6
            TipoTexto = ttNumerico
          end
          object edtDesMarca: TEditFocus
            Tag = 99
            Left = 148
            Top = 31
            Width = 230
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 3
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtDesFornecedor: TEditFocus
            Tag = 99
            Left = 148
            Top = 56
            Width = 230
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 5
            NormalColor = 16768952
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object edtFornecedor: TEditFocus
            Tag = 99
            Left = 76
            Top = 56
            Width = 70
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
            OnExit = edtFornecedorExit
            OnKeyPress = edtFornecedorKeyPress
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = True
            TamCampo = 8
            TipoTexto = ttNumerico
          end
          object btnConfirmar: TBitBtnLocked
            Left = 602
            Top = 59
            Width = 74
            Height = 22
            Caption = 'C&onfirma'
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
            TabOrder = 10
            OnClick = btnConfirmarClick
          end
          object btnCancelaItem: TBitBtnLocked
            Left = 677
            Top = 59
            Width = 74
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
            TabOrder = 11
            OnClick = btnCancelaItemClick
          end
          object edtDescrUnidade: TEditFocus
            Tag = 99
            Left = 521
            Top = 32
            Width = 230
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            Color = 16768952
            Enabled = False
            ImeName = 'Portugu'#234's (Brasil ABNT)'
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
        end
      end
    end
    object tbsCondPag: TTabSheet
      Caption = '2 - Condi'#231#245'es de Pagamento Especiais'
      ImageIndex = 1
      object cxgCndPag: TcxGridCitel
        Left = 0
        Top = 39
        Width = 1094
        Height = 633
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgCndPagTableView: TcxGridDBTableViewCitel
          OnKeyDown = cxgCndPagTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsCndPag
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsCustomize.ColumnFiltering = False
          OptionsCustomize.ColumnGrouping = False
          OptionsCustomize.ColumnHidingOnGrouping = False
          OptionsData.Deleting = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          OptionsView.HeaderAutoHeight = True
          Zebra = True
          Destaque = False
          CorZebra = clMoneyGreen
          object cxgCndPagTableViewCODCND: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CODCND'
          end
          object cxgCndPagTableViewDESCND: TcxGridDBColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'DESCND'
            Width = 280
          end
          object cxgCndPagTableViewCNDPAG: TcxGridDBColumn
            Caption = 'Condi'#231#227'o de Pagamento'
            DataBinding.FieldName = 'CNDPAG'
            Width = 438
          end
        end
        object cxgCndPagLevel: TcxGridLevel
          GridView = cxgCndPagTableView
        end
      end
      object pnlCndPag: TPanel
        Left = 0
        Top = 0
        Width = 1094
        Height = 39
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 1
        object ColorLabel2: TColorLabel
          Left = 202
          Top = 41
          Width = 55
          Height = 14
          Caption = '(S)im (N)'#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          CorDestaque = clRed
        end
        object btnIncCndPag: TBitBtnLocked
          Left = 8
          Top = 9
          Width = 120
          Height = 22
          Caption = '&Selecionar'
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
          OnClick = btnIncCndPagClick
        end
        object btnCadastroCondPagto: TBitBtnLocked
          Left = 134
          Top = 9
          Width = 239
          Height = 22
          Caption = 'Ca&dastro de Condi'#231#245'es de Pagamento'
          Glyph.Data = {
            DE010000424DDE01000000000000760000002800000024000000120000000100
            0400000000006801000000000000000000001000000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00666666666666
            6666666666666666666666660000666666666666666666666FFFFFFFFFFFF666
            000066000000000000666666888888888888F666000066877777777770666666
            8F6666666668F6660000668FFFFFFFFF706666668F6FF6FFFF68F6660000668F
            44F4444F706666668F8868888668F6660000668FFFFFFFFF706666668F6FF6FF
            FF68F6660000668F44F4444F706666668F8868888668F6660000668FFFFFFFFF
            706666668F6666666668F6660000668FFFFFFF0F706666668F6FF6668F68F66F
            0000668F00FFF0B0706664668F88FF68F8F8F6F80000668F0F0F0B0F00064466
            8F8F8F8F8F888F880000668FF0B0B0F0FBF044668FF8F8F8F8F6F88800006688
            880F0F0FBFBF446688888F8F86666688000066666660B0FBFBFB4466666668F8
            66666F880000666666660FBFBFB044666666668FFFFFF8880000666666666000
            0006446666666668888886880000666666666666666666666666666666666666
            0000}
          NumGlyphs = 2
          TabOrder = 1
          OnClick = btnCadastroCondPagtoClick
        end
      end
    end
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 212
    Top = 144
  end
  object dtsCondPagEsp: TDataSource
    OnStateChange = dtsCondPagEspStateChange
    Left = 1060
    Top = 396
  end
  object dtsCadCes: TDataSource
    Left = 1060
    Top = 356
  end
  object cdsCndPag: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 1060
    Top = 441
    object cdsCndPagCODCND: TStringField
      FieldName = 'CODCND'
      Size = 10
    end
    object cdsCndPagDESCND: TStringField
      FieldName = 'DESCND'
    end
    object cdsCndPagCNDPAG: TStringField
      FieldName = 'CNDPAG'
      Size = 100
    end
    object cdsCndPagSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
  end
  object dtsCndPag: TDataSource
    DataSet = cdsCndPag
    Left = 1024
    Top = 440
  end
end
