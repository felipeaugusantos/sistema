inherited frmPedeDadosCampoSQL: TfrmPedeDadosCampoSQL
  Width = 640
  Height = 698
  Caption = 'Informa'#231#245'es sobre a campo da consulta'
  ExplicitWidth = 640
  ExplicitHeight = 698
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 627
    Width = 634
    ExplicitTop = 627
    ExplicitWidth = 634
    inherited FlwBotoes: TFlowPanel
      Width = 630
      ExplicitWidth = 630
    end
    inherited btnSair: TBitBtnLocked
      Left = 554
      ExplicitLeft = 554
    end
  end
  inherited pnlStatus: TPanel
    Top = 653
    Width = 634
    ExplicitTop = 653
    ExplicitWidth = 634
    inherited pnlNomeForm: TPanel
      Left = 463
      ExplicitLeft = 463
    end
    inherited pnlInfo: TPanel
      Width = 463
      ExplicitWidth = 463
    end
  end
  object pgcCampos: TPageControl [2]
    Left = 0
    Top = 41
    Width = 634
    Height = 586
    ActivePage = tbsGeral
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 3
    StyleElements = [seFont, seBorder]
    object tbsGeral: TTabSheet
      Caption = '&1 - Configura'#231#245'es diversas'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 626
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object lblCalMsk: TLabel
          Left = 12
          Top = 21
          Width = 159
          Height = 14
          Caption = 'Campo que identifica CNPJ / CPF:'
        end
        object dbeCALMSK: TDBLookupComboBox
          Tag = 99
          Left = 174
          Top = 13
          Width = 224
          Height = 22
          DataField = 'CAM_CALMSK'
          DataSource = dtsCampos
          KeyField = 'CAM_ALIAS_'
          ListField = 'CAM_ALIAS_'
          ListSource = dtsCopiaCampos
          TabOrder = 0
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 41
        Width = 626
        Height = 513
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        object Label5: TLabel
          Left = 11
          Top = 9
          Width = 201
          Height = 14
          Caption = 'Lista de Valores para o filtro da pesquisa:'
        end
        object dbeLisVal: TDBMemoFocus
          Left = 11
          Top = 24
          Width = 201
          Height = 235
          DataField = 'CAM_LISVAL'
          DataSource = dtsCampos
          ScrollBars = ssVertical
          TabOrder = 0
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object rdgConfig: TRadioGroup
          Left = 232
          Top = 9
          Width = 345
          Height = 104
          Caption = 'Configura'#231#227'o ligada ao campo'
          Items.Strings = (
            'Sem Configura'#231#227'o'
            #205'cones de Status de Pedidos de Venda'
            #205'cones de Status Financeiro de Pedidos de Venda'
            #205'cones de Status Adiantamento de Pedidos de Venda')
          TabOrder = 1
        end
      end
    end
    object tbsEstilos: TTabSheet
      Caption = '&2 - Estilos de linha'
      ImageIndex = 1
      object pnlStyles: TPanel
        Left = 0
        Top = 0
        Width = 626
        Height = 554
        Align = alClient
        BevelInner = bvLowered
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object pnlTopStyle: TPanel
          Left = 1
          Top = 1
          Width = 624
          Height = 88
          Align = alTop
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object Label1: TLabel
            Left = 25
            Top = 16
            Width = 49
            Height = 14
            Caption = 'Operador:'
          end
          object Label3: TLabel
            Left = 45
            Top = 40
            Width = 28
            Height = 14
            Caption = 'Valor:'
          end
          object Label2: TLabel
            Left = 8
            Top = 64
            Width = 62
            Height = 14
            Caption = 'Cor do texto:'
          end
          object cmbOperador: TComboBoxFocus
            Left = 76
            Top = 12
            Width = 76
            Height = 22
            Style = csDropDownList
            TabOrder = 0
            Items.Strings = (
              '='
              '<>'
              '>'
              '<'
              '>='
              '<=')
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
          end
          object edtValor: TEditFocus
            Left = 76
            Top = 36
            Width = 207
            Height = 22
            Alignment = taLeftJustify
            TabOrder = 1
            NormalColor = clWindow
            FocusColor = clInfoBk
            RequeridoColor = clRed
            Requerido = False
            CompZeros = False
            TamCampo = 0
            TipoTexto = ttAlfanumerico
          end
          object grbEstiloTexto: TGroupBox
            Left = 289
            Top = 12
            Width = 254
            Height = 45
            Caption = 'Estilo do texto'
            TabOrder = 3
            object chkNegrito: TCheckBox
              Left = 16
              Top = 19
              Width = 57
              Height = 17
              Caption = 'Negrito'
              TabOrder = 0
            end
            object chkItalico: TCheckBox
              Left = 104
              Top = 19
              Width = 49
              Height = 17
              Caption = 'It'#225'lico'
              TabOrder = 1
            end
            object chkSublinhado: TCheckBox
              Left = 168
              Top = 19
              Width = 75
              Height = 17
              Caption = 'Sublinhado'
              TabOrder = 2
            end
          end
          object btnIncluir: TBitBtnLocked
            Left = 289
            Top = 60
            Width = 77
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
            TabOrder = 4
            OnClick = btnIncluirClick
          end
          object cxcCor: TcxColorComboBox
            Left = 76
            Top = 60
            Properties.ClearKey = 46
            Properties.ColorComboStyle = cxccsComboList
            Properties.CustomColors = <>
            Properties.DefaultDescription = 'Nenhuma cor selecionada'
            Properties.ImmediatePost = True
            Properties.ShowDescriptions = False
            TabOrder = 2
            Width = 121
          end
        end
        object cxgStyles: TcxGrid
          Left = 1
          Top = 89
          Width = 624
          Height = 431
          Align = alClient
          TabOrder = 1
          object cxvStyles: TcxGridDBBandedTableView
            Navigator.Buttons.CustomButtons = <>
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = '<Nehum estilo cadastrado>'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            Styles.Background = cxStyle1
            Bands = <
              item
                Caption = 'Estilos espec'#237'ficos por linha'
                Width = 502
              end>
            object cxvStylesColumn1: TcxGridDBBandedColumn
              Caption = 'Operador'
              DataBinding.FieldName = 'OPERADOR'
              HeaderAlignmentHorz = taCenter
              Options.Editing = False
              Width = 71
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object cxvStylesColumn2: TcxGridDBBandedColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'VALOR'
              HeaderAlignmentHorz = taCenter
              Width = 338
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object cxvStylesColumn3: TcxGridDBBandedColumn
              Caption = 'Cor do texto'
              DataBinding.FieldName = 'COR'
              PropertiesClassName = 'TcxColorComboBoxProperties'
              Properties.ColorComboStyle = cxccsComboList
              Properties.CustomColors = <>
              Properties.ImmediatePost = True
              Properties.ShowDescriptions = False
              FooterAlignmentHorz = taCenter
              HeaderAlignmentHorz = taCenter
              Width = 148
              Position.BandIndex = 0
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
          end
          object cxgStylesLevel1: TcxGridLevel
            GridView = cxvStyles
          end
        end
        object Panel4: TPanel
          Left = 1
          Top = 520
          Width = 624
          Height = 33
          Align = alBottom
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object btnDelEstilo: TBitBtnLocked
            Left = 253
            Top = 6
            Width = 96
            Height = 20
            Caption = '&Excluir estilo'
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
            TabOrder = 0
            OnClick = btnDelEstiloClick
          end
        end
      end
    end
  end
  object Panel3: TPanel [3]
    Left = 0
    Top = 0
    Width = 634
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    object Label4: TLabel
      Left = 20
      Top = 15
      Width = 36
      Height = 14
      Caption = 'Campo:'
    end
    object dbeALIAS_: TDBEditFocus
      Tag = 99
      Left = 62
      Top = 10
      Width = 114
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'CAM_ALIAS_'
      DataSource = dtsCampos
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbTITULO: TDBEditFocus
      Tag = 99
      Left = 178
      Top = 10
      Width = 435
      Height = 22
      CharCase = ecUpperCase
      Color = 16768952
      DataField = 'CAM_TITULO'
      DataSource = dtsCampos
      TabOrder = 1
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 272
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 152
    Top = 392
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 72
    Top = 312
  end
  object dtsCampos: TDataSource
    Left = 504
    Top = 296
  end
  object dtsCopiaCampos: TDataSource
    Left = 144
    Top = 264
  end
  object cxStyleRepository1: TcxStyleRepository
    Left = 424
    Top = 344
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
    end
  end
end
