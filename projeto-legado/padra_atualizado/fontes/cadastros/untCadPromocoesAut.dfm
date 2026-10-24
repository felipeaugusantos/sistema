inherited frmCadPromocoesAut: TfrmCadPromocoesAut
  Width = 1024
  Height = 768
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Promo'#231#227'o de Produtos para Venda Automatizada'
  WindowState = wsMaximized
  OnDestroy = FormDestroy
  OnResize = FormResize
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    BevelInner = bvNone
    BevelOuter = bvNone
    Padding.Left = 2
    Padding.Top = 2
    Padding.Right = 2
    Padding.Bottom = 1
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      Height = 25
      ExplicitTop = 2
      ExplicitWidth = 1014
      ExplicitHeight = 25
      inherited btnIncluir: TBitBtnLocked
        Height = 25
        ExplicitHeight = 25
      end
      inherited btnGravar: TBitBtnLocked
        Height = 25
        ExplicitHeight = 25
      end
      inherited btnAlterar: TBitBtnLocked
        Height = 25
        ExplicitHeight = 25
      end
      inherited btnExcluir: TBitBtnLocked
        Height = 25
        ExplicitHeight = 25
      end
      inherited btnCancela: TBitBtnLocked
        Height = 25
        ExplicitHeight = 25
      end
      inherited btnPesquisa: TBitBtnLocked
        Height = 25
        ExplicitHeight = 25
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 933
      Height = 25
      ExplicitLeft = 933
      ExplicitHeight = 25
    end
  end
  inherited pgcDados: TPageControl
    Width = 1018
    Height = 695
    ActivePage = tbsClientes
    ExplicitWidth = 1018
    ExplicitHeight = 695
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 1010
      ExplicitHeight = 663
      object pnlGeral: TPanel
        Left = 0
        Top = 0
        Width = 653
        Height = 663
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object pnlCabecalho: TPanel
          Left = 0
          Top = 0
          Width = 653
          Height = 49
          Align = alTop
          BevelEdges = []
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Label1: TLabel
            Left = 11
            Top = 6
            Width = 39
            Height = 14
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'C'#243'digo:'
          end
          object Label4: TLabel
            Left = 11
            Top = 30
            Width = 132
            Height = 14
            Caption = 'Promo'#231#227'o por: % Desconto'
          end
          object dbeCodPro: TDBEditFocus
            Tag = 99
            Left = 53
            Top = 2
            Width = 70
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PPA_CODPPA'
            DataSource = dtsCadPpa
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 0
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
          object dbeDesPro: TDBEditFocus
            Tag = 99
            Left = 129
            Top = 2
            Width = 521
            Height = 22
            CharCase = ecUpperCase
            DataField = 'PPA_DESPPA'
            DataSource = dtsCadPpa
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TipoTexto = ttAlfanumerico
          end
        end
        object pnlTabelas: TPanel
          Left = 0
          Top = 49
          Width = 653
          Height = 65
          Align = alTop
          BevelOuter = bvNone
          Color = 16770261
          ParentBackground = False
          TabOrder = 1
          object lblTabPreco: TLabel
            Left = 0
            Top = 0
            Width = 653
            Height = 14
            Align = alTop
            Caption = 'Tabelas de Pre'#231'o da Promo'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 169
          end
          object lblLegCondicoes: TLabel
            Left = 488
            Top = 19
            Width = 167
            Height = 45
            Alignment = taCenter
            Caption = 
              'Esta promo'#231#227'o possui '#13#10'condi'#231#245'es de pagamento.'#13#10'O prazo m'#233'dio se' +
              'r'#225' ignorado.'
            Font.Charset = ANSI_CHARSET
            Font.Color = clRed
            Font.Height = -12
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Visible = False
          end
          object clbTabPre: TCheckListBox
            Left = 11
            Top = 22
            Width = 464
            Height = 43
            OnClickCheck = clbTabPreClickCheck
            Columns = 4
            ImeName = 'Portugu'#234's (Brasil ABNT)'
            ItemHeight = 14
            Items.Strings = (
              'Tabela de Pre'#231'o 1'
              'Tabela de Pre'#231'o 2'
              'Tabela de Pre'#231'o 3'
              'Tabela de Pre'#231'o 4'
              'Tabela de Pre'#231'o 5'
              'Tabela de Pre'#231'o 6'
              'Tabela de Pre'#231'o 7')
            Style = lbOwnerDrawFixed
            TabOrder = 0
            OnDrawItem = clbTabPreDrawItem
            OnExit = clbTabPreExit
            OnKeyDown = clbTabPreKeyDown
          end
        end
        object pnlOpcoesGerais: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 279
          Width = 647
          Height = 69
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 3
          object Label7: TLabel
            Left = 0
            Top = 0
            Width = 647
            Height = 14
            Align = alTop
            Caption = 'Op'#231#245'es Gerais'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 81
          end
          object chkPromocaoRestritaClientesNaoConsumidor: TDBCheckBox
            Left = 9
            Top = 22
            Width = 316
            Height = 14
            Caption = 'Promo'#231#227'o restrita a clientes n'#227'o consumidor.'
            DataField = 'PPA_RESNCO'
            DataSource = dtsCadPpa
            TabOrder = 0
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            WordWrap = True
          end
          object chkTraPro: TDBCheckBox
            Left = 9
            Top = 50
            Width = 347
            Height = 14
            Caption = 'Utilizar pre'#231'o da promo'#231#227'o para trava de pre'#231'o m'#237'nimo exigido?'
            DataField = 'PPA_TRAPRO'
            DataSource = dtsCadPpa
            TabOrder = 2
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            WordWrap = True
          end
          object chkEntIme: TDBCheckBox
            Left = 9
            Top = 36
            Width = 316
            Height = 14
            Caption = 'Permite entrega imediata?'
            DataField = 'PPA_ENTIME'
            DataSource = dtsCadPpa
            TabOrder = 1
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            WordWrap = True
          end
          object chkEntFut: TDBCheckBox
            Left = 349
            Top = 36
            Width = 297
            Height = 14
            Caption = 'Permite entrega futura?'
            DataField = 'PPA_ENTFUT'
            DataSource = dtsCadPpa
            TabOrder = 4
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            WordWrap = True
          end
          object chkEcommerce: TDBCheckBox
            Left = 349
            Top = 18
            Width = 297
            Height = 14
            Caption = 'Promo'#231#227'o para e-commerce'
            DataField = 'PPA_ECOMME'
            DataSource = dtsCadPpa
            TabOrder = 3
            ValueChecked = 'S'
            ValueUnchecked = 'N'
            WordWrap = True
            OnClick = chkEcommerceClick
          end
        end
        object pnlChecks: TPanel
          Left = 0
          Top = 351
          Width = 653
          Height = 108
          Align = alTop
          AutoSize = True
          BevelOuter = bvNone
          TabOrder = 4
          object Panel6: TPanel
            Left = 0
            Top = 0
            Width = 653
            Height = 36
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object rdgComPro: TcxDBRadioGroup
              Left = 10
              Top = -2
              Caption = 'Comiss'#227'o'
              DataBinding.DataField = 'PPA_COMPRO'
              DataBinding.DataSource = dtsCadPpa
              ParentBackground = False
              ParentColor = False
              Properties.Columns = 2
              Properties.DefaultValue = 'P'
              Properties.Items = <
                item
                  Caption = 'Informada nesta promo'#231#227'o'
                  Value = 'P'
                end
                item
                  Caption = 'Definida nas configura'#231#245'es do sistema'
                  Value = 'V'
                end>
              Style.Color = 16770261
              TabOrder = 1
              OnClick = rdgComProClick
              Height = 34
              Width = 643
            end
            object btnHlpCom: TBitBtnLocked
              Left = 672
              Top = 11
              Width = 19
              Height = 19
              Hint = 'Clique aqui para mais informa'#231#245'es sobre a promo'#231#227'o selecionada!'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000010000000800000010000000100000
                0008000000010000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
                0B60000000070000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
                27EA0000000E0000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
                30EC0000000D0000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
                1A51000000050000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000010000000600000011000000140000
                000A000000020000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000670503AA999532EFF4528
                187A000000070000000100000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
                4AF724150D490000000800000002000000000000000000000000000000000000
                0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
                9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
                000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
                AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
                00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
                76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
                000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
                70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
                000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
                C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
                0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
                77E570533B9A17100A2500000002000000000000000000000000000000000000
                0000000000000000000000000000000000010000000100000002000000030000
                0002000000020000000100000000000000000000000000000000}
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              TabStop = False
              OnClick = btnHlpComClick
            end
          end
          object Panel7: TPanel
            Left = 0
            Top = 36
            Width = 653
            Height = 36
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object rdgQtdLim: TcxDBRadioGroup
              Left = 10
              Top = 0
              Caption = 'Aplicar quantidade limite da promo'#231#227'o'
              DataBinding.DataField = 'PPA_IDXQTD'
              DataBinding.DataSource = dtsCadPpa
              ParentBackground = False
              ParentColor = False
              Properties.Columns = 2
              Properties.DefaultValue = 0
              Properties.Items = <
                item
                  Caption = 'Para cada empresa participante da promo'#231#227'o'
                  Value = 0
                end
                item
                  Caption = 'Para todas as empresas participantes da promo'#231#227'o'
                  Value = 1
                end>
              Style.Color = 16770261
              TabOrder = 1
              Height = 34
              Width = 643
            end
            object btnHlpQtdLim: TBitBtnLocked
              Left = 672
              Top = 11
              Width = 19
              Height = 21
              Hint = 'Clique aqui para mais informa'#231#245'es sobre a op'#231#227'o selecionada!'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              Glyph.Data = {
                36040000424D3604000000000000360000002800000010000000100000000100
                2000000000000004000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000010000000800000010000000100000
                0008000000010000000000000000000000000000000000000000000000000000
                000000000000000000000000000000000006301D125F8A4C2DED854526ED2814
                0B60000000070000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000D9F6A49EAD8A471FFD3985FFF8345
                27EA0000000E0000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000CAC7F5EECF5D9AEFFDEB285FF8D50
                30EC0000000D0000000000000000000000000000000000000000000000000000
                00000000000000000000000000000000000532271F50A28368D29E7D61D22F23
                1A51000000050000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000010000000600000011000000140000
                000A000000020000000000000000000000000000000000000000000000000000
                0000000000000000000000000000000000000000000670503AA999532EFF4528
                187A000000070000000100000000000000000000000000000000000000000000
                000000000000000000000000000000000000000000079F795AD7E5BF92FFAF72
                4AF724150D490000000800000002000000000000000000000000000000000000
                0000000000000000000100000004000000060000000868534089D6AD86FFF1D0
                9FFFB4774BFF693D24AE0D080520000000020000000000000000000000000000
                000000000000000000034C301E7A7B4526D0522F1A8F0A09071A9A6745E0ECD2
                AAFFF6D39CFFD8A470FF75452ABD000000060000000000000000000000000000
                00000000000000000005B6855FF7E8D4B2FFAF7A53FF2D1C1154745C489EC59B
                76FFF8E7BCFFF3CC95FFA0623BF7000000070000000000000000000000000000
                000000000000000000039C7D5EC9EFDDBFFFCAA682FF7E5E45B2917C61B4C197
                70FFF9ECC4FFE8CCA4FF845435C7000000050000000000000000000000000000
                000000000000000000012B241D38CFAF8CF7E8D2B3FFCBA888FFBF9674FFF0E1
                C5FFDDBF9EFFAF7D58F01F140D34000000010000000000000000000000000000
                0000000000000000000000000001231E182D877158A5C3A07DEED9BA96FFBA99
                77E570533B9A17100A2500000002000000000000000000000000000000000000
                0000000000000000000000000000000000010000000100000002000000030000
                0002000000020000000100000000000000000000000000000000}
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 0
              TabStop = False
              OnClick = btnHlpQtdLimClick
            end
          end
          object pnlTrazerPrecoSugestao: TPanel
            Left = 0
            Top = 72
            Width = 653
            Height = 36
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            object rdgProPre: TcxDBRadioGroup
              Left = 9
              Top = 0
              Caption = 'Trazer pre'#231'o de sugest'#227'o no faturamento'
              DataBinding.DataField = 'PPA_PROPRE'
              DataBinding.DataSource = dtsCadPpa
              ParentBackground = False
              ParentColor = False
              Properties.Columns = 2
              Properties.DefaultValue = '0'
              Properties.Items = <
                item
                  Caption = 'Pre'#231'o de Promo'#231#227'o'
                  Value = '1'
                end
                item
                  Caption = 'Pre'#231'o de Tabela'
                  Value = '2'
                end>
              Style.BorderStyle = ebsUltraFlat
              Style.Color = 16770261
              TabOrder = 0
              Height = 34
              Width = 643
            end
          end
        end
        object pnlValidades: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 117
          Width = 647
          Height = 156
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object Label2: TLabel
            Left = 0
            Top = 0
            Width = 647
            Height = 14
            Align = alTop
            Caption = 'Validades da Promo'#231#227'o'
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 128
          end
          object grdValidades: TcxGridCitel
            Left = 0
            Top = 67
            Width = 647
            Height = 89
            Align = alClient
            TabOrder = 1
            LookAndFeel.ScrollbarMode = sbmClassic
            object grdValidadesTv: TcxGridDBTableViewCitel
              OnKeyDown = grdValidadesTvKeyDown
              Navigator.Buttons.CustomButtons = <>
              OnCellDblClick = grdValidadesTvCellDblClick
              DataController.DataSource = dtsPpaVal
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object grdValidadesTvColumn1: TcxGridDBColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'VPA_CODPRO'
                Width = 100
              end
              object grdValidadesTvDESVPA: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'VPA_DESVPA'
                Width = 200
              end
              object grdValidadesTvDTAINI: TcxGridDBColumn
                Caption = 'Data Inicial'
                DataBinding.FieldName = 'VPA_DTAINI'
                Width = 100
              end
              object grdValidadesTvDTAFIN: TcxGridDBColumn
                Caption = 'Data Final'
                DataBinding.FieldName = 'VPA_DTAFIN'
                Width = 100
              end
            end
            object grdValidadesLv: TcxGridLevel
              GridView = grdValidadesTv
            end
          end
          object Panel4: TPanel
            Left = 0
            Top = 14
            Width = 647
            Height = 53
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label3: TLabel
              Left = 12
              Top = 8
              Width = 118
              Height = 14
              Caption = 'Descri'#231#227'o da Promo'#231#227'o:'
            end
            object Label5: TLabel
              Left = 12
              Top = 32
              Width = 39
              Height = 14
              Caption = 'Per'#237'odo:'
            end
            object Label6: TLabel
              Left = 139
              Top = 32
              Width = 6
              Height = 14
              Caption = #224
            end
            object btnAddVpa: TBitBtnLocked
              Left = 495
              Top = 29
              Width = 74
              Height = 22
              Caption = 'Confirmar'
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
              OnClick = btnAddVpaClick
            end
            object btnCancelVpa: TBitBtnLocked
              Left = 573
              Top = 29
              Width = 74
              Height = 22
              Caption = 'Cancelar'
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
              OnClick = btnCancelVpaClick
            end
            object edtDtaInicial: TMaskEditFocus
              Tag = 99
              Left = 57
              Top = 28
              Width = 69
              Height = 22
              EditMask = '99/99/9999;1;_'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              TabOrder = 1
              Text = '  /  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object edtDtaFinal: TMaskEditFocus
              Tag = 99
              Left = 156
              Top = 28
              Width = 70
              Height = 22
              EditMask = '99/99/9999;1;_'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              MaxLength = 10
              ParentFont = False
              TabOrder = 2
              Text = '  /  /    '
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              ValidaData = False
            end
            object edtDesPro: TEditFocus
              Left = 136
              Top = 4
              Width = 511
              Height = 22
              Alignment = taLeftJustify
              MaxLength = 80
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
        object pnlCndPag: TPanel
          AlignWithMargins = True
          Left = 3
          Top = 462
          Width = 647
          Height = 196
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 5
          object Label8: TLabel
            Left = 0
            Top = 0
            Width = 647
            Height = 14
            Align = alTop
            Caption = 'Condi'#231#245'es de Pagamento da Promo'#231#227'o     '
            Font.Charset = ANSI_CHARSET
            Font.Color = clBlack
            Font.Height = 14
            Font.Name = 'Arial'
            Font.Pitch = fpVariable
            Font.Style = [fsBold]
            ParentFont = False
            Layout = tlCenter
            ExplicitWidth = 231
          end
          object pnlCndPagCab: TPanel
            Left = 0
            Top = 14
            Width = 647
            Height = 55
            Align = alTop
            BevelOuter = bvNone
            Color = 16770261
            ParentBackground = False
            TabOrder = 0
            object lblCndPag: TLabel
              Left = 99
              Top = 9
              Width = 61
              Height = 14
              Alignment = taRightJustify
              Caption = 'Cond. Pagto:'
            end
            object ColorLabel2: TColorLabel
              Left = 202
              Top = 34
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
            object lblJurRem: TLabel
              Left = 10
              Top = 34
              Width = 148
              Height = 14
              Alignment = taRightJustify
              Caption = 'Aplicar Juros Remanescentes:'
            end
            object edtCodCnd: TEditFocus
              Tag = 99
              Left = 162
              Top = 6
              Width = 65
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 3
              TabOrder = 0
              OnExit = edtCodCndExit
              OnKeyPress = edtCodCndKeyPress
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 3
              TipoTexto = ttNumerico
            end
            object btnIncCndPag: TBitBtnLocked
              Left = 495
              Top = 31
              Width = 74
              Height = 22
              Caption = 'C&onfirmar'
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
              OnClick = btnIncCndPagClick
            end
            object btnCancelCndPag: TBitBtnLocked
              Left = 573
              Top = 31
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
              TabOrder = 3
              OnClick = btnCancelCndPagClick
            end
            object edtDesCnd: TEditFocus
              Left = 232
              Top = 6
              Width = 413
              Height = 22
              HelpType = htKeyword
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
            object edtJurRem: TEditFocus
              Tag = 99
              Left = 162
              Top = 31
              Width = 35
              Height = 22
              Alignment = taLeftJustify
              CharCase = ecUpperCase
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 1
              TabOrder = 1
              Text = 'S'
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = True
              TamCampo = 1
              TipoTexto = ttAlfabetico
            end
          end
          object cxgCndPag: TcxGridCitel
            Left = 0
            Top = 69
            Width = 647
            Height = 127
            Align = alClient
            TabOrder = 1
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxgCndPagTv: TcxGridDBTableViewCitel
              OnKeyDown = cxgCndPagTvKeyDown
              Navigator.Buttons.CustomButtons = <>
              OnCellDblClick = cxgCndPagTvCellDblClick
              DataController.DataSource = dtsPpaCnd
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsCustomize.ColumnFiltering = False
              OptionsCustomize.ColumnGrouping = False
              OptionsCustomize.ColumnHidingOnGrouping = False
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Editing = False
              OptionsData.Inserting = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              OptionsView.HeaderAutoHeight = True
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxgCndPagTvCODCND: TcxGridDBColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'NPA_CODCND'
                Width = 70
              end
              object cxgCndPagTvDESCND: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'CND_DESCRI'
                Width = 280
              end
              object cxgCndPagTvCNDPAG: TcxGridDBColumn
                Caption = 'Condi'#231#227'o de Pagamento'
                DataBinding.FieldName = 'CND_CNDPAG'
                OnGetDisplayText = cxgCndPagTvCNDPAGGetDisplayText
                Width = 400
              end
              object cxgCndPagTvJURREM: TcxGridDBColumn
                Caption = 
                  'Aplicar Juros Remanescentes sobre os dias que ultrapassarem o pr' +
                  'azo m'#233'dio'
                DataBinding.FieldName = 'NPA_JURREM'
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ValueChecked = 'S'
                Properties.ValueUnchecked = 'N'
                HeaderAlignmentHorz = taCenter
                Width = 210
              end
            end
            object cxgCndPagLv: TcxGridLevel
              GridView = cxgCndPagTv
            end
          end
        end
      end
      object pnlEmpresa: TPanel
        AlignWithMargins = True
        Left = 656
        Top = 3
        Width = 351
        Height = 657
        Align = alRight
        Alignment = taRightJustify
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label16: TLabel
          Left = 0
          Top = 0
          Width = 351
          Height = 14
          Align = alTop
          Caption = 'Empresas da Promo'#231#227'o'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 131
        end
        object clbEmpresa: TCheckListBox
          Left = 0
          Top = 14
          Width = 351
          Height = 617
          Align = alClient
          Ctl3D = True
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ItemHeight = 14
          ParentCtl3D = False
          TabOrder = 0
        end
        object Panel5: TPanel
          Left = 0
          Top = 631
          Width = 351
          Height = 26
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 1
          object btnMarcarTodasEmpresas: TBitBtnLocked
            Left = 0
            Top = 0
            Width = 164
            Height = 25
            Caption = 'Marcar todas as Empresas'
            TabOrder = 0
            OnClick = btnMarcarTodasEmpresasClick
          end
          object btnDesmarcarTodasEmpresas: TBitBtnLocked
            Left = 170
            Top = 0
            Width = 164
            Height = 25
            Caption = 'Desmarcar todas as Empresas'
            TabOrder = 1
            OnClick = btnDesmarcarTodasEmpresasClick
          end
        end
      end
    end
    object tbsItens: TTabSheet
      Caption = '&2 - Itens da Promo'#231#227'o'
      ImageIndex = 1
      object pnlInformacoesItens: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 218
        Align = alTop
        AutoSize = True
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object pnlDadosItem: TPanel
          Left = 1
          Top = 1
          Width = 1008
          Height = 216
          Align = alTop
          AutoSize = True
          Color = 16770261
          ParentBackground = False
          TabOrder = 0
          object Panel8: TPanel
            Left = 1
            Top = 1
            Width = 1006
            Height = 148
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 0
            object Label9: TLabel
              Left = 356
              Top = 10
              Width = 84
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Produto:'
            end
            object Label12: TLabel
              Left = 19
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
            object Label13: TLabel
              Left = 382
              Top = 33
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
            object Label14: TLabel
              Left = 54
              Top = 33
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
            object lblDescricao: TLabel
              Left = 6
              Top = 56
              Width = 81
              Height = 14
              Alignment = taRightJustify
              Caption = 'Descri'#231#227'o Inicial:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label15: TLabel
              Left = 31
              Top = 79
              Width = 56
              Height = 14
              Alignment = taRightJustify
              Caption = 'Refer'#234'ncia:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label18: TLabel
              Left = 363
              Top = 56
              Width = 77
              Height = 14
              Alignment = taRightJustify
              Caption = 'Descri'#231#227'o Final:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lbl1: TLabel
              Left = 327
              Top = 125
              Width = 114
              Height = 14
              Alignment = taRightJustify
              AutoSize = False
              Caption = 'Prz M'#233'd. Cond. Pagto.:'
            end
            object Label11: TLabel
              Left = 363
              Top = 79
              Width = 78
              Height = 14
              Alignment = taRightJustify
              Caption = 'C'#243'digo Unidade:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label17: TLabel
              Left = 34
              Top = 102
              Width = 56
              Height = 14
              Alignment = taRightJustify
              Caption = 'Qtde.Limite:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object lbl2: TLabel
              Left = 387
              Top = 102
              Width = 55
              Height = 14
              Alignment = taRightJustify
              Caption = 'Qtd.M'#237'nima:'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = []
              ParentFont = False
            end
            object Label21: TLabel
              Left = 25
              Top = 129
              Width = 62
              Height = 14
              Alignment = taRightJustify
              Caption = '% Desconto:'
            end
            object edtCodIte: TEditFocus
              Tag = 99
              Left = 444
              Top = 6
              Width = 70
              Height = 22
              Alignment = taLeftJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              MaxLength = 5
              TabOrder = 2
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
              Left = 515
              Top = 6
              Width = 220
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              ReadOnly = True
              TabOrder = 3
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
              Left = 90
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
            object edtDesGrupo: TEditFocus
              Left = 161
              Top = 6
              Width = 194
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
            object edtFornecedor: TEditFocus
              Tag = 99
              Left = 444
              Top = 29
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
              TabOrder = 6
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
            object edtDesFornecedor: TEditFocus
              Left = 515
              Top = 29
              Width = 220
              Height = 22
              TabStop = False
              Alignment = taLeftJustify
              Color = 16768952
              Enabled = False
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 7
              NormalColor = 16768952
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtMarca: TEditFocus
              Tag = 99
              Left = 90
              Top = 29
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
              TabOrder = 4
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
              Left = 161
              Top = 29
              Width = 194
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
            object edtDescriIni: TEditFocus
              Tag = 99
              Left = 90
              Top = 52
              Width = 265
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
              TabOrder = 8
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtRefere: TEditFocus
              Tag = 99
              Left = 90
              Top = 75
              Width = 265
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
              TabOrder = 10
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtDescriFin: TEditFocus
              Tag = 99
              Left = 444
              Top = 52
              Width = 291
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
              TabOrder = 9
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttAlfanumerico
            end
            object edtPrzMed: TEditFocus
              Tag = 99
              Left = 444
              Top = 121
              Width = 65
              Height = 22
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 15
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
            end
            object edtUnidade: TEditFocus
              Tag = 99
              Left = 444
              Top = 75
              Width = 36
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
              TabOrder = 11
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
            object edtQtdLim: TEditFocus
              Tag = 99
              Left = 90
              Top = 98
              Width = 70
              Height = 22
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 12
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = ',0.00'
            end
            object edtQtdMin: TEditFocus
              Tag = 99
              Left = 444
              Top = 98
              Width = 65
              Height = 22
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 13
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = ',0.00'
            end
            object edtPerDes: TEditFocus
              Tag = 99
              Left = 90
              Top = 121
              Width = 70
              Height = 22
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 14
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
          end
          object Panel9: TPanel
            Left = 1
            Top = 149
            Width = 1006
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object Label19: TLabel
              Left = 29
              Top = 23
              Width = 121
              Height = 14
              Alignment = taRightJustify
              Caption = '% Comiss. Vend. Interno:'
            end
            object Label20: TLabel
              Left = 257
              Top = 23
              Width = 139
              Height = 14
              Alignment = taRightJustify
              Caption = '% Comiss. Repres. Ext. Loja:'
            end
            object lbl8: TLabel
              Left = 506
              Top = 23
              Width = 152
              Height = 14
              Alignment = taRightJustify
              Caption = '% Comiss. Repres. Ext. Distrib.:'
            end
            object Label10: TLabel
              Left = 0
              Top = 0
              Width = 1006
              Height = 16
              Align = alTop
              AutoSize = False
              Caption = 'Comiss'#227'o'
              Font.Charset = ANSI_CHARSET
              Font.Color = clBlack
              Font.Height = 14
              Font.Name = 'Arial'
              Font.Pitch = fpVariable
              Font.Style = [fsBold]
              ParentFont = False
            end
            object edtComVar: TEditFocus
              Tag = 99
              Left = 156
              Top = 18
              Width = 70
              Height = 22
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 0
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
            object edtComAta: TEditFocus
              Tag = 99
              Left = 402
              Top = 18
              Width = 70
              Height = 22
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
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
            object edtComDis: TEditFocus
              Tag = 99
              Left = 665
              Top = 18
              Width = 70
              Height = 22
              Alignment = taRightJustify
              ImeName = 'Portugu'#234's (Brasil ABNT)'
              TabOrder = 2
              NormalColor = clWindow
              FocusColor = clInfoBk
              RequeridoColor = clRed
              Requerido = False
              CompZeros = False
              TamCampo = 0
              TipoTexto = ttNumerico
              EditFormat = '#,##0.00'
            end
          end
          object Panel10: TPanel
            Left = 1
            Top = 190
            Width = 1006
            Height = 25
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 2
            object btnConfirmar: TBitBtnLocked
              Left = 586
              Top = 1
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
              TabOrder = 0
              OnClick = btnConfirmarClick
            end
            object btnCancelaItem: TBitBtnLocked
              Left = 661
              Top = 1
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
              TabOrder = 1
              OnClick = btnCancelaItemClick
            end
          end
        end
      end
      object cxgItens: TcxGridCitel
        Left = 0
        Top = 218
        Width = 1010
        Height = 445
        Align = alClient
        TabOrder = 1
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = False
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgItensTableView: TcxGridDBBandedTableViewCitel
          OnKeyDown = cxgItensTableViewKeyDown
          Navigator.Buttons.CustomButtons = <>
          OnCellDblClick = cxgItensTableViewCellDblClick
          DataController.DataSource = dtsPpaIte
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
              Caption = 'Promo'#231#227'o'
            end
            item
              Caption = 'Valores da promo'#231#227'o'
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 1'
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 2'
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 3'
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 4'
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 5'
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 6'
            end
            item
              Caption = 'Valores da promo'#231#227'o - Tabela 7'
            end
            item
              Caption = 'Valores do cadastro de produtos'
            end
            item
              Caption = 'Comiss'#227'o'
            end>
          Zebra = True
          Destaque = False
          DestacarRegistro = False
          CorZebra = clMoneyGreen
          object cxgItensIPA_CODITE: TcxGridDBBandedColumn
            Caption = 'C'#243'd. item'
            DataBinding.FieldName = 'IPA_CODITE'
            Width = 70
            Position.BandIndex = 0
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensITE_CODFAB: TcxGridDBBandedColumn
            Caption = 'C'#243'd. fab.'
            DataBinding.FieldName = 'ITE_CODFAB'
            Width = 80
            Position.BandIndex = 0
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensITE_DESITE: TcxGridDBBandedColumn
            Caption = 'Descri'#231#227'o'
            DataBinding.FieldName = 'ITE_DESITE'
            Width = 260
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
          object cxgItensIPA_QTDLIM: TcxGridDBBandedColumn
            Caption = 'Qtd. limite'
            DataBinding.FieldName = 'IPA_QTDLIM'
            Width = 80
            Position.BandIndex = 2
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPA_QTDMIN: TcxGridDBBandedColumn
            Caption = 'Qtd. M'#237'nima'
            DataBinding.FieldName = 'IPA_QTDMIN'
            Width = 80
            Position.BandIndex = 2
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPA_PRZMED: TcxGridDBBandedColumn
            Caption = 'Prazo m'#233'dio'
            DataBinding.FieldName = 'IPA_PRZMED'
            Width = 80
            Position.BandIndex = 2
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPA_PERDES: TcxGridDBBandedColumn
            Caption = '% Desconto'
            DataBinding.FieldName = 'IPA_PERDES'
            Width = 80
            Position.BandIndex = 2
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPA_PRECUS: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPA_PRECUS'
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPA_CUSREA: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPA_CUSREA'
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARBRU: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPA_MARBRU'
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARLIQ: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPA_MARLIQ'
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPA_PREVEN: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPA_PREVEN'
            Width = 80
            Position.BandIndex = 3
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPA_PRECUS1: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPA_PRECUS'
            Width = 80
            Position.BandIndex = 4
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPA_CUSRE1: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPA_CUSRE1'
            Width = 80
            Position.BandIndex = 4
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARBR1: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPA_MARBR1'
            Width = 80
            Position.BandIndex = 4
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARLQ1: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPA_MARLQ1'
            Width = 80
            Position.BandIndex = 4
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPA_PREVE1: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPA_PREVE1'
            Width = 80
            Position.BandIndex = 4
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPA_PRECUS2: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPA_PRECUS'
            Width = 80
            Position.BandIndex = 5
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPA_CUSRE2: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPA_CUSRE2'
            Width = 80
            Position.BandIndex = 5
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARBR2: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPA_MARBR2'
            Width = 80
            Position.BandIndex = 5
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARLQ2: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPA_MARLQ2'
            Width = 80
            Position.BandIndex = 5
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPA_PREVE2: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPA_PREVE2'
            Width = 80
            Position.BandIndex = 5
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPA_PRECUS3: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPA_PRECUS'
            Width = 80
            Position.BandIndex = 6
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPA_CUSRE3: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPA_CUSRE3'
            Width = 80
            Position.BandIndex = 6
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARBR3: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPA_MARBR3'
            Width = 80
            Position.BandIndex = 6
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARLQ3: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPA_MARLQ3'
            Width = 80
            Position.BandIndex = 6
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPA_PREVE3: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPA_PREVE3'
            Width = 80
            Position.BandIndex = 6
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPA_PRECUS4: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPA_PRECUS'
            Width = 80
            Position.BandIndex = 7
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPA_CUSRE4: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPA_CUSRE4'
            Width = 80
            Position.BandIndex = 7
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARBR4: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPA_MARBR4'
            Width = 80
            Position.BandIndex = 7
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARLQ4: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPA_MARLQ4'
            Width = 80
            Position.BandIndex = 7
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPA_PREVE4: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPA_PREVE4'
            Width = 80
            Position.BandIndex = 7
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPA_PRECUS5: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPA_PRECUS'
            Width = 80
            Position.BandIndex = 8
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPA_CUSRE5: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPA_CUSRE5'
            Width = 80
            Position.BandIndex = 8
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARBR5: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPA_MARBR5'
            Width = 80
            Position.BandIndex = 8
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARLQ5: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPA_MARLQ5'
            Width = 80
            Position.BandIndex = 8
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPA_PREVE5: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPA_PREVE5'
            Width = 80
            Position.BandIndex = 8
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPA_PRECUS6: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPA_PRECUS'
            Width = 80
            Position.BandIndex = 9
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPA_CUSRE6: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPA_CUSRE6'
            Width = 80
            Position.BandIndex = 9
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARBR6: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPA_MARBR6'
            Width = 80
            Position.BandIndex = 9
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARLQ6: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPA_MARLQ6'
            Width = 80
            Position.BandIndex = 9
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPA_PREVE6: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPA_PREVE6'
            Width = 80
            Position.BandIndex = 9
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensIPA_PRECUS7: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'IPA_PRECUS'
            Width = 80
            Position.BandIndex = 10
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPA_CUSRE7: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'IPA_CUSRE7'
            Width = 80
            Position.BandIndex = 10
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARBR7: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta'
            DataBinding.FieldName = 'IPA_MARBR7'
            Width = 80
            Position.BandIndex = 10
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensIPA_MARLQ7: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida'
            DataBinding.FieldName = 'IPA_MARLQ7'
            Width = 80
            Position.BandIndex = 10
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensIPA_PREVE7: TcxGridDBBandedColumn
            Caption = 'Pr. promo'#231#227'o'
            DataBinding.FieldName = 'IPA_PREVE7'
            Width = 80
            Position.BandIndex = 10
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensITE_PRECUS: TcxGridDBBandedColumn
            Caption = 'Pr. custo'
            DataBinding.FieldName = 'ITE_PRECUS'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensITE_CUSREA: TcxGridDBBandedColumn
            Caption = 'Custo real'
            DataBinding.FieldName = 'ITE_CUSREA'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR1: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 1'
            DataBinding.FieldName = 'ITE_MARBR1'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ1: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 1'
            DataBinding.FieldName = 'ITE_MARLQ1'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 3
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE1: TcxGridDBBandedColumn
            Caption = 'Pr. venda 1'
            DataBinding.FieldName = 'ITE_PREVE1'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 4
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR2: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 2'
            DataBinding.FieldName = 'ITE_MARBR2'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 5
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ2: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 2'
            DataBinding.FieldName = 'ITE_MARLQ2'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 6
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE2: TcxGridDBBandedColumn
            Caption = 'Pr. venda 2'
            DataBinding.FieldName = 'ITE_PREVE2'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 7
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR3: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 3'
            DataBinding.FieldName = 'ITE_MARBR3'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 8
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ3: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 3'
            DataBinding.FieldName = 'ITE_MARLQ3'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 9
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE3: TcxGridDBBandedColumn
            Caption = 'Pr. venda 3'
            DataBinding.FieldName = 'ITE_PREVE3'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 10
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR4: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 4'
            DataBinding.FieldName = 'ITE_MARBR4'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 11
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ4: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 4'
            DataBinding.FieldName = 'ITE_MARLQ4'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 12
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE4: TcxGridDBBandedColumn
            Caption = 'Pr. venda 4'
            DataBinding.FieldName = 'ITE_PREVE4'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 13
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR5: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 5'
            DataBinding.FieldName = 'ITE_MARBR5'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 14
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ5: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 5'
            DataBinding.FieldName = 'ITE_MARLQ5'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 15
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE5: TcxGridDBBandedColumn
            Caption = 'Pr. venda 5'
            DataBinding.FieldName = 'ITE_PREVE5'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 16
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR6: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 6'
            DataBinding.FieldName = 'ITE_MARBR6'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 17
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ6: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 6'
            DataBinding.FieldName = 'ITE_MARLQ6'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 18
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE6: TcxGridDBBandedColumn
            Caption = 'Pr. venda 6'
            DataBinding.FieldName = 'ITE_PREVE6'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 19
            Position.RowIndex = 0
          end
          object cxgItensITE_MARBR7: TcxGridDBBandedColumn
            Caption = 'Mrg. bruta 7'
            DataBinding.FieldName = 'ITE_MARBR7'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 20
            Position.RowIndex = 0
          end
          object cxgItensITE_MARLQ7: TcxGridDBBandedColumn
            Caption = 'Mrg. l'#237'quida 7'
            DataBinding.FieldName = 'ITE_MARLQ7'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 21
            Position.RowIndex = 0
          end
          object cxgItensITE_PREVE7: TcxGridDBBandedColumn
            Caption = 'Pr. venda 7'
            DataBinding.FieldName = 'ITE_PREVE7'
            Width = 80
            Position.BandIndex = 11
            Position.ColIndex = 22
            Position.RowIndex = 0
          end
          object cxgItensITE_PREMED: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o M'#233'dio'
            DataBinding.FieldName = 'ITE_PREMED'
            Width = 74
            Position.BandIndex = 11
            Position.ColIndex = 23
            Position.RowIndex = 0
          end
          object cxgItensITE_PREULT: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o '#218'lt.Compra'
            DataBinding.FieldName = 'ITE_PREULT'
            Width = 103
            Position.BandIndex = 11
            Position.ColIndex = 24
            Position.RowIndex = 0
          end
          object cxgItensITE_IMPULT: TcxGridDBBandedColumn
            Caption = 'Pre'#231'o '#218'lt.Compra+Imp.'
            DataBinding.FieldName = 'ITE_IMPULT'
            Width = 138
            Position.BandIndex = 11
            Position.ColIndex = 25
            Position.RowIndex = 0
          end
          object cxgItensIPA_COMVAR: TcxGridDBBandedColumn
            Caption = 'Com. V.I.'
            DataBinding.FieldName = 'IPA_COMVAR'
            Width = 80
            Position.BandIndex = 12
            Position.ColIndex = 0
            Position.RowIndex = 0
          end
          object cxgItensIPA_COMATA: TcxGridDBBandedColumn
            Caption = 'Com. V.E.'
            DataBinding.FieldName = 'IPA_COMATA'
            Width = 80
            Position.BandIndex = 12
            Position.ColIndex = 1
            Position.RowIndex = 0
          end
          object cxgItensIPA_COMDIS: TcxGridDBBandedColumn
            Caption = 'Com. dist.'
            DataBinding.FieldName = 'IPA_COMDIS'
            Width = 80
            Position.BandIndex = 12
            Position.ColIndex = 2
            Position.RowIndex = 0
          end
        end
        object cxgItenslevel: TcxGridLevel
          GridView = cxgItensTableView
        end
      end
    end
    object tbsClientes: TTabSheet
      Caption = '&3- Clientes da Promo'#231#227'o'
      ImageIndex = 2
      object pnlPesqCli: TPanel
        Left = 0
        Top = 0
        Width = 1010
        Height = 81
        Align = alTop
        Color = 16770261
        ParentBackground = False
        TabOrder = 0
        object lbl3: TLabel
          Left = 60
          Top = 13
          Width = 35
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cliente:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl4: TLabel
          Left = 525
          Top = 12
          Width = 48
          Height = 14
          Alignment = taRightJustify
          Caption = 'Atividade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl5: TLabel
          Left = 59
          Top = 36
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Cidade:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl6: TLabel
          Left = 538
          Top = 36
          Width = 36
          Height = 14
          Alignment = taRightJustify
          Caption = 'Estado:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lbl7: TLabel
          Left = 7
          Top = 59
          Width = 88
          Height = 14
          Alignment = taRightJustify
          Caption = '1 - CNPJ / 2 - CPF:'
        end
        object lblCategoria: TLabel
          Left = 522
          Top = 59
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Categoria:'
        end
        object edtCodCli: TEditFocus
          Tag = 99
          Left = 98
          Top = 9
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 8
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnExit = edtCodCliExit
          OnKeyPress = edtCodCliKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 8
          TipoTexto = ttNumerico
        end
        object edtNomCli: TEditFocus
          Left = 164
          Top = 9
          Width = 350
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
        object edtCodAti: TEditFocus
          Tag = 99
          Left = 576
          Top = 9
          Width = 65
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 3
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnExit = edtCodAtiExit
          OnKeyPress = edtCodAtiKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 3
          TipoTexto = ttNumerico
        end
        object edtDesAti: TEditFocus
          Left = 642
          Top = 9
          Width = 350
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 3
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtCodCid: TEditFocus
          Tag = 99
          Left = 98
          Top = 32
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 5
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnExit = edtCodCidExit
          OnKeyPress = edtCodCidKeyPress
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 5
          TipoTexto = ttNumerico
        end
        object edtDesCid: TEditFocus
          Left = 164
          Top = 32
          Width = 350
          Height = 22
          TabStop = False
          Alignment = taLeftJustify
          Color = 16768952
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          ReadOnly = True
          TabOrder = 5
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
        end
        object edtEstado: TEditFocus
          Tag = 99
          Left = 576
          Top = 32
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 6
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 2
          TipoTexto = ttAlfanumerico
        end
        object edtCgcCpf: TEditFocus
          Tag = 99
          Left = 98
          Top = 55
          Width = 65
          Height = 22
          Hint = 'Pressione INSERT para inserir um novo cliente'
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 7
          Text = '1'
          OnChange = edtCgcCpfChange
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = True
          TamCampo = 1
          TipoTexto = ttNumerico
        end
        object edtNuCnPj: TMaskEditFocus
          Left = 164
          Top = 55
          Width = 350
          Height = 22
          ReadOnly = True
          TabOrder = 8
          Text = ''
          OnEnter = edtNuCnPjEnter
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          ValidaData = False
        end
        object btnIncCli: TBitBtnLocked
          Left = 840
          Top = 55
          Width = 74
          Height = 22
          Caption = 'C&onfirmar'
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
          OnClick = btnIncCliClick
        end
        object btnCancelCli: TBitBtnLocked
          Left = 918
          Top = 55
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
          OnClick = btnCancelCliClick
        end
        object cbxCategoria: TComboBox
          Left = 576
          Top = 55
          Width = 65
          Height = 22
          Style = csDropDownList
          Enabled = False
          TabOrder = 9
          OnKeyDown = cbxCategoriaKeyDown
        end
      end
      object cxgClientes: TcxGridCitel
        Left = 0
        Top = 81
        Width = 1010
        Height = 582
        Align = alClient
        TabOrder = 1
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxgClientesTv: TcxGridDBTableViewCitel
          OnKeyDown = cxgClientesTvKeyDown
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsPpaCli
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.Visible = True
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = ' '
          OptionsView.GroupByBox = False
          Zebra = True
          Destaque = True
          CorZebra = clMoneyGreen
          object cxgClientesTvColumn1: TcxGridDBColumn
            Caption = 'C'#243'digo'
            DataBinding.FieldName = 'CPA_CODCLI'
            Width = 66
          end
          object cxgClientesTvColumn2: TcxGridDBColumn
            Caption = 'Nome do Cliente'
            DataBinding.FieldName = 'PRO_NOMCLI'
            Width = 250
          end
          object cxgClientesTvColumn5: TcxGridDBColumn
            Caption = 'CNPJ / CPF'
            DataBinding.FieldName = 'PRO_CGCCPF'
            OnGetDisplayText = cxgClientesTvColumn5GetDisplayText
          end
          object cxgClientesTvColumn4: TcxGridDBColumn
            Caption = 'Cidade / Estado'
            DataBinding.FieldName = 'PRO_CIDEST'
            Width = 206
          end
          object cxgClientesTvColumn3: TcxGridDBColumn
            Caption = 'Atividade'
            DataBinding.FieldName = 'PRO_ATIVID'
            Width = 150
          end
          object cxgClientesTvColumn6: TcxGridDBColumn
            Caption = 'Categoria'
            DataBinding.FieldName = 'PRO_CATEGO'
            Width = 90
          end
        end
        object cxgClientesLv: TcxGridLevel
          GridView = cxgClientesTv
        end
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 671
      ExplicitLeft = 671
    end
    inherited pnlInfo: TPanel
      Width = 671
      ExplicitWidth = 671
    end
  end
  object dtsCadPpa: TDataSource
    OnStateChange = dtsCadPpaStateChange
    Left = 926
    Top = 528
  end
  object dtsPpaIte: TDataSource
    Left = 928
    Top = 612
  end
  object dtsPpaCli: TDataSource
    Left = 928
    Top = 656
  end
  object dtsPpaVal: TDataSource
    Left = 928
    Top = 572
  end
  object dtsPpaCnd: TDataSource
    Left = 928
    Top = 704
  end
end
