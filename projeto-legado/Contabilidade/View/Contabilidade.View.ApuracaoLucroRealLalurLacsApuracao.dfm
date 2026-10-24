inherited frmApuracaoLucroRealLalurLacsApuracao: TfrmApuracaoLucroRealLalurLacsApuracao
  Width = 515
  Height = 694
  Caption = 'Apura'#231#227'o Lucro Real'
  OnDestroy = FormDestroy
  ExplicitWidth = 515
  ExplicitHeight = 694
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 623
    Width = 509
    TabOrder = 1
    ExplicitTop = 623
    ExplicitWidth = 509
    inherited FlwBotoes: TFlowPanel
      Width = 505
      ExplicitWidth = 505
      inherited btnConfirma: TBitBtnLocked
        ModalResult = 0
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 429
      Caption = '&Sair'
      ExplicitLeft = 429
    end
  end
  inherited pnlStatus: TPanel
    Top = 649
    Width = 509
    TabOrder = 2
    ExplicitTop = 649
    ExplicitWidth = 509
    inherited pnlNomeForm: TPanel
      Left = 338
      ExplicitLeft = 338
    end
    inherited pnlInfo: TPanel
      Width = 338
      ExplicitWidth = 338
    end
  end
  object pnlPeriodo: TPanel [2]
    Left = 0
    Top = 0
    Width = 509
    Height = 63
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object cxLabel1: TcxLabel
      Left = 10
      Top = 37
      Caption = 'Periodo:'
      Transparent = True
    end
    object edtDataInicio: TcxDateEdit
      Left = 59
      Top = 34
      Enabled = False
      Properties.ReadOnly = True
      TabOrder = 0
      Width = 121
    end
    object edtDataFin: TcxDateEdit
      Left = 182
      Top = 34
      Enabled = False
      Properties.ReadOnly = True
      TabOrder = 1
      Width = 121
    end
    object cxLabel14: TcxLabel
      Left = 4
      Top = 10
      Caption = 'Empresa:'
      Transparent = True
    end
    object edtEmpSel: TEditFocus
      Tag = 99
      Left = 59
      Top = 6
      Width = 57
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmpSel: TEditFocus
      Left = 120
      Top = 6
      Width = 384
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
  end
  object pgcApuracao: TcxPageControl [3]
    Left = 0
    Top = 63
    Width = 509
    Height = 560
    Align = alClient
    TabOrder = 3
    Properties.ActivePage = tsLacs
    Properties.CustomButtons.Buttons = <>
    Properties.Style = 2
    ClientRectBottom = 560
    ClientRectRight = 509
    ClientRectTop = 26
    object tsLacs: TcxTabSheet
      Caption = 'LACS'
      ImageIndex = 0
      object cxLabel2: TcxLabel
        Left = 177
        Top = 11
        Caption = 'Lucro Antes da CSLL:'
      end
      object edtLucroAntesCSSL: TCurrencyEditFocus
        Left = 292
        Top = 10
        Enabled = False
        Properties.DisplayFormat = ' ,0.00;- ,0.00'
        Properties.ReadOnly = True
        StyleFocused.Color = clInfoBk
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 87
      end
      object gbLacsAdicoesExclusoes: TcxGroupBox
        Left = 2
        Top = 37
        Alignment = alCenterCenter
        TabOrder = 1
        Height = 62
        Width = 505
        object cxLabel3: TcxLabel
          Left = 230
          Top = 7
          Caption = '+ Adi'#231#245'es:'
        end
        object cxLabel4: TcxLabel
          Left = 221
          Top = 34
          Caption = '- Exclus'#245'es:'
        end
        object edtAdicoesLacs: TCurrencyEditFocus
          Left = 291
          Top = 6
          Enabled = False
          Properties.DisplayFormat = ' ,0.00;- ,0.00'
          Properties.ReadOnly = True
          StyleFocused.Color = clInfoBk
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          Width = 87
        end
        object edtExclusoesLacs: TCurrencyEditFocus
          Left = 291
          Top = 33
          Enabled = False
          Properties.DisplayFormat = ' ,0.00;- ,0.00'
          Properties.ReadOnly = True
          StyleFocused.Color = clInfoBk
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          Width = 87
        end
        object btnAjustesLacs: TcxButton
          Left = 380
          Top = 32
          Width = 122
          Height = 25
          Caption = 'Ajustes'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000001974455874536F6674776172650041646F626520496D616765526561
            647971C9653C0000001B744558745469746C6500496E697469616C5374617465
            3B4F7074696F6E733B0CED1447000002AE49444154785E6D936D48535118C7FF
            F7DE6DA1AD19644946980929096A8A29A84BB01A6A197D30A5179430222848BF
            447DF153F821482AE8534152C2BE2481989121F886621ACDAC99502BE8C52D49
            D79CB9DD9D737AEEBD7A5DD4D8739E8773EEF3FB9FFFB33BA9A5D33320CB56A7
            80C0EA97B258CF549867C626626A64E86ED3FE0A21846A5157B8F35C551A8C23
            187915A4B7F2F57DAE4304EEF5CC9401502808C018542670EDC6330311D75C57
            5F0AB106A46E0E20636B2254A65590286089C538965662686A70C2FDF8A5A10A
            09A76A8BE05FFC0D3A0627022380F66CD06E055375004C4094363E0496517334
            1F4FBA2750535D00EFD75F86322D825196004E904854408DB1BF6F1061048970
            F8FCCBA874E5E3933F4CAAE6304D1B00A8996BB73101B8D3314CF68411DCCCFF
            44FCE751D78446B053090B055960E48F0AD990E11A5E4814868E4CD1373885C1
            B1B7282DCC424AB24317BFDCFA00167D68DA803803B88C3582D52621185AC2B7
            C00238791E19F7A2E14439EE3FEC43415E26CE5C68AB092ECC8F5AB4C1701D62
            741A2B871C53D0D533064912080482385E5988B41DC9385655841783AFB12F6F
            6FE71BAFAF57D67C30069008A2DA3039D76B0681EDDB92100A8571BED1058F67
            06F58DADF04CCDE0ECC943585C58C4FC9C7F58D66F20340BA4AB3773ADD6A75D
            5E9203EFEC6744A32A462767D17CA91E9E691F189D4FBC7AC7BADD6D37750B8C
            0056AB04C125F395B62932FAFAC791BE33050AD56525F978DAEFC1E183C5B02A
            0AB2F6EC56A4DA2BCD524BAB7BC0664B707208F3CF030079D9A918181AC16647
            22BECFCDC3E52A414E76067C1FBFA0D3DD8B4D0E3BA6A7DF3FD7241328ACE68B
            119733732A76D9ED5B72399094929A7EBDE174F5C65BB73BC2E1D0CFAB9262F9
            115B599E2445F1DF8883C914B6039517DB2B8E348BDCE2BA76001B56F7A53FFB
            E5BF7A2344E11D0000000049454E44AE426082}
          TabOrder = 4
          TabStop = False
          OnClick = btnAjustesLacsClick
        end
      end
      object cxLabel5: TcxLabel
        Left = 8
        Top = 106
        Caption = 'Base de C'#225'lculo antes da Compensa'#231#227'o da BC Negativa:'
      end
      object edtBCAntesCompesacaoLacs: TCurrencyEditFocus
        Left = 293
        Top = 105
        Enabled = False
        Properties.DisplayFormat = ' ,0.00;- ,0.00'
        Properties.ReadOnly = True
        StyleFocused.Color = clInfoBk
        TabOrder = 2
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 87
      end
      object cxGroupBox1: TcxGroupBox
        Left = 2
        Top = 133
        Alignment = alCenterCenter
        TabOrder = 3
        Height = 36
        Width = 505
        object cxLabel6: TcxLabel
          Left = 125
          Top = 7
          Caption = '- Compensa'#231#227'o da BC Negativa:'
        end
        object edtCompesacaoLacs: TCurrencyEditFocus
          Left = 291
          Top = 6
          Enabled = False
          Properties.DisplayFormat = ' ,0.00;- ,0.00'
          Properties.ReadOnly = True
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          Width = 87
        end
        object btnPrejuizosLacs: TcxButton
          Left = 380
          Top = 5
          Width = 122
          Height = 25
          Caption = 'Preju'#237'zos Fiscais'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            6100000024744558745469746C6500436F6C6C617073654669656C645069766F
            745461626C653B5069766F743B83E6DD1E000000B849444154785EBDD33D0A02
            311005E010D81F4552ACA59E43C51B686BD6DE7B58D9595A791145D8C6561616
            AFE20DC617C8C0B2318CA218F88A64E031611245445158DA6EF614E3EA524002
            06862F185F57BA29EDE9BE2EA9ABB6AB33EA3DE8C36077A8A88D03D2DB72418F
            E336E0CE5D1D5ADD841DE497E9A4BACE67D4E5CE5D9D03A21D4001231833BF2F
            DEE94043CA77657E9F0B534894B0C42988EF00B2D814A400A91BF371C0BF3B90
            FF8214F0E3298432FE8D5F7902F1077F82204B1ABD0000000049454E44AE4260
            82}
          TabOrder = 2
          TabStop = False
          OnClick = btnPrejuizosLacsClick
        end
      end
      object cxLabel7: TcxLabel
        Left = 151
        Top = 176
        Caption = '= Base de C'#225'lculo da CSLL:'
      end
      object edtBaseCalculoCSLL: TCurrencyEditFocus
        Left = 293
        Top = 175
        Enabled = False
        Properties.DisplayFormat = ' ,0.00;- ,0.00'
        Properties.ReadOnly = True
        StyleFocused.Color = clInfoBk
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 87
      end
      object gbAdicoesLacs: TcxGroupBox
        Left = 2
        Top = 200
        Caption = 'Adi'#231#245'es (Resumo por Natureza)'
        TabOrder = 5
        Height = 105
        Width = 505
        object GridAdicoesLacs: TcxGridCitel
          Left = 2
          Top = 19
          Width = 501
          Height = 84
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridAdicoesLacsTableView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsAdicoesLacs
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridAdicoesLacsTableViewNAT_CODIGO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'NAT_CODIGO'
            end
            object GridAdicoesLacsTableViewNAT_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'NAT_DESCRI'
              Width = 250
            end
            object GridAdicoesLacsTableViewNAT_VALRES: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'NAT_VALRES'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 100
            end
            object GridAdicoesLacsTableViewCREDEB: TcxGridDBColumn
              Caption = 'D/C'
              DataBinding.FieldName = 'CREDEB'
              Width = 70
            end
          end
          object GridAdicoesLacsLevel1: TcxGridLevel
            GridView = GridAdicoesLacsTableView
          end
        end
      end
      object gbExclusoesLacs: TcxGroupBox
        Left = 2
        Top = 311
        Caption = 'Exclus'#245'es (Resumo por Natureza)'
        TabOrder = 6
        Height = 105
        Width = 505
        object GridExclusoesLacs: TcxGridCitel
          Left = 2
          Top = 19
          Width = 501
          Height = 84
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridExclusoesLacsTableView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsExclusoesLacs
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridExclusoesLacsTableViewNAT_CODIGO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'NAT_CODIGO'
            end
            object GridExclusoesLacsTableViewNAT_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'NAT_DESCRI'
              Width = 250
            end
            object GridExclusoesLacsTableViewNAT_VALRES: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'NAT_VALRES'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 100
            end
            object GridExclusoesLacsTableViewCREDEB: TcxGridDBColumn
              Caption = 'D/C'
              DataBinding.FieldName = 'CREDEB'
              Width = 70
            end
          end
          object GridExclusoesLacsLevel1: TcxGridLevel
            GridView = GridExclusoesLacsTableView
          end
        end
      end
      object gbCompensacoesLacs: TcxGroupBox
        Left = 2
        Top = 420
        Caption = 'Compensa'#231#245'es (Resumo)'
        TabOrder = 7
        Height = 105
        Width = 505
        object GridCompensacoesLacs: TcxGridCitel
          Left = 2
          Top = 19
          Width = 501
          Height = 84
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridCompensacoesLacsTableView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsCompensacoesLacs
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridCompensacoesLacsTableViewNAT_CODIGO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'NAT_CODIGO'
              Visible = False
              VisibleForCustomization = False
            end
            object GridCompensacoesLacsTableViewNAT_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'NAT_DESCRI'
              Width = 250
            end
            object GridCompensacoesLacsTableViewNAT_VALRES: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'NAT_VALRES'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 100
            end
          end
          object GridCompensacoesLacsLevel1: TcxGridLevel
            GridView = GridCompensacoesLacsTableView
          end
        end
      end
    end
    object tsLalur: TcxTabSheet
      Caption = 'LAIR'
      ImageIndex = 1
      object cxLabel8: TcxLabel
        Left = 146
        Top = 11
        Caption = 'Lucro L'#237'quido Antes do IRPJ:'
      end
      object edtLucroAntesIRPJ: TCurrencyEditFocus
        Left = 292
        Top = 10
        Enabled = False
        Properties.DisplayFormat = ' ,0.00;- ,0.00'
        Properties.ReadOnly = True
        StyleFocused.Color = clInfoBk
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 87
      end
      object gbLalurAdicoesExclusoes: TcxGroupBox
        Left = 2
        Top = 37
        Alignment = alCenterCenter
        TabOrder = 2
        Height = 62
        Width = 505
        object cxLabel9: TcxLabel
          Left = 230
          Top = 7
          Caption = '+ Adi'#231#245'es:'
        end
        object cxLabel10: TcxLabel
          Left = 221
          Top = 34
          Caption = '- Exclus'#245'es:'
        end
        object edtAdicoesLalur: TCurrencyEditFocus
          Left = 291
          Top = 6
          Enabled = False
          Properties.DisplayFormat = ' ,0.00;- ,0.00'
          Properties.ReadOnly = True
          StyleFocused.Color = clInfoBk
          TabOrder = 2
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          Width = 87
        end
        object edtExclusoesLalur: TCurrencyEditFocus
          Left = 291
          Top = 33
          Enabled = False
          Properties.DisplayFormat = ' ,0.00;- ,0.00'
          Properties.ReadOnly = True
          StyleFocused.Color = clInfoBk
          TabOrder = 3
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          Width = 87
        end
        object btnAjustesLalur: TcxButton
          Left = 380
          Top = 32
          Width = 122
          Height = 25
          Caption = 'Ajustes'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            610000001974455874536F6674776172650041646F626520496D616765526561
            647971C9653C0000001B744558745469746C6500496E697469616C5374617465
            3B4F7074696F6E733B0CED1447000002AE49444154785E6D936D48535118C7FF
            F7DE6DA1AD19644946980929096A8A29A84BB01A6A197D30A5179430222848BF
            447DF153F821482AE8534152C2BE2481989121F886621ACDAC99502BE8C52D49
            D79CB9DD9D737AEEBD7A5DD4D8739E8773EEF3FB9FFFB33BA9A5D33320CB56A7
            80C0EA97B258CF549867C626626A64E86ED3FE0A21846A5157B8F35C551A8C23
            187915A4B7F2F57DAE4304EEF5CC9401502808C018542670EDC6330311D75C57
            5F0AB106A46E0E20636B2254A65590286089C538965662686A70C2FDF8A5A10A
            09A76A8BE05FFC0D3A0627022380F66CD06E055375004C4094363E0496517334
            1F4FBA2750535D00EFD75F86322D825196004E904854408DB1BF6F1061048970
            F8FCCBA874E5E3933F4CAAE6304D1B00A8996BB73101B8D3314CF68411DCCCFF
            44FCE751D78446B053090B055960E48F0AD990E11A5E4814868E4CD1373885C1
            B1B7282DCC424AB24317BFDCFA00167D68DA803803B88C3582D52621185AC2B7
            C00238791E19F7A2E14439EE3FEC43415E26CE5C68AB092ECC8F5AB4C1701D62
            741A2B871C53D0D533064912080482385E5988B41DC9385655841783AFB12F6F
            6FE71BAFAF57D67C30069008A2DA3039D76B0681EDDB92100A8571BED1058F67
            06F58DADF04CCDE0ECC943585C58C4FC9C7F58D66F20340BA4AB3773ADD6A75D
            5E9203EFEC6744A32A462767D17CA91E9E691F189D4FBC7AC7BADD6D37750B8C
            0056AB04C125F395B62932FAFAC791BE33050AD56525F978DAEFC1E183C5B02A
            0AB2F6EC56A4DA2BCD524BAB7BC0664B707208F3CF030079D9A918181AC16647
            22BECFCDC3E52A414E76067C1FBFA0D3DD8B4D0E3BA6A7DF3FD7241328ACE68B
            119733732A76D9ED5B72399094929A7EBDE174F5C65BB73BC2E1D0CFAB9262F9
            115B599E2445F1DF8883C914B6039517DB2B8E348BDCE2BA76001B56F7A53FFB
            E5BF7A2344E11D0000000049454E44AE426082}
          TabOrder = 4
          TabStop = False
          OnClick = btnAjustesLalurClick
        end
      end
      object cxLabel11: TcxLabel
        Left = 48
        Top = 106
        Caption = 'Lucro Real Antes da Compensa'#231#227'o de Preju'#237'zos:'
      end
      object edtBCAntesCompesacaoLalur: TCurrencyEditFocus
        Left = 293
        Top = 105
        Enabled = False
        Properties.DisplayFormat = ' ,0.00;- ,0.00'
        Properties.ReadOnly = True
        StyleFocused.Color = clInfoBk
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 87
      end
      object cxGroupBox2: TcxGroupBox
        Left = 2
        Top = 133
        Alignment = alCenterCenter
        TabOrder = 5
        Height = 36
        Width = 505
        object cxLabel12: TcxLabel
          Left = 125
          Top = 7
          Caption = '- Compensa'#231#227'o de Preju'#237'zos:'
        end
        object edtCompesacaoLalur: TCurrencyEditFocus
          Left = 291
          Top = 6
          Enabled = False
          Properties.DisplayFormat = ' ,0.00;- ,0.00'
          Properties.ReadOnly = True
          StyleFocused.Color = clInfoBk
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          Width = 87
        end
        object btnPrejuizosLalur: TcxButton
          Left = 380
          Top = 5
          Width = 122
          Height = 25
          Caption = 'Preju'#237'zos Fiscais'
          OptionsImage.Glyph.SourceDPI = 96
          OptionsImage.Glyph.Data = {
            89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
            6100000024744558745469746C6500436F6C6C617073654669656C645069766F
            745461626C653B5069766F743B83E6DD1E000000B849444154785EBDD33D0A02
            311005E010D81F4552ACA59E43C51B686BD6DE7B58D9595A791145D8C6561616
            AFE20DC617C8C0B2318CA218F88A64E031611245445158DA6EF614E3EA524002
            06862F185F57BA29EDE9BE2EA9ABB6AB33EA3DE8C36077A8A88D03D2DB72418F
            E336E0CE5D1D5ADD841DE497E9A4BACE67D4E5CE5D9D03A21D4001231833BF2F
            DEE94043CA77657E9F0B534894B0C42988EF00B2D814A400A91BF371C0BF3B90
            FF8214F0E3298432FE8D5F7902F1077F82204B1ABD0000000049454E44AE4260
            82}
          TabOrder = 2
          TabStop = False
          OnClick = btnPrejuizosLalurClick
        end
      end
      object cxLabel13: TcxLabel
        Left = 155
        Top = 176
        Caption = '= Base de C'#225'lculo do IRPJ:'
      end
      object edtBaseCalculoIRPJ: TCurrencyEditFocus
        Left = 293
        Top = 175
        Enabled = False
        Properties.DisplayFormat = ' ,0.00;- ,0.00'
        Properties.ReadOnly = True
        StyleFocused.Color = clInfoBk
        TabOrder = 7
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        Width = 87
      end
      object gbAdicoesLalur: TcxGroupBox
        Left = 2
        Top = 200
        Caption = 'Adi'#231#245'es (Resumo por Natureza)'
        TabOrder = 8
        Height = 105
        Width = 505
        object GridAdicoesLalur: TcxGridCitel
          Left = 2
          Top = 19
          Width = 501
          Height = 84
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridAdicoesLalurTableView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsAdicoesLalur
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridAdicoesLalurTableViewNAT_CODIGO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'NAT_CODIGO'
            end
            object GridAdicoesLalurTableViewNAT_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'NAT_DESCRI'
              Width = 250
            end
            object GridAdicoesLalurTableViewNAT_VALRES: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'NAT_VALRES'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 100
            end
            object GridAdicoesLalurTableViewCREDEB: TcxGridDBColumn
              Caption = 'D/C'
              DataBinding.FieldName = 'CREDEB'
              Width = 70
            end
          end
          object GridAdicoesLalurLevel1: TcxGridLevel
            GridView = GridAdicoesLalurTableView
          end
        end
      end
      object gbExclusoesLalur: TcxGroupBox
        Left = 2
        Top = 311
        Caption = 'Exclus'#245'es (Resumo por Natureza)'
        TabOrder = 9
        Height = 105
        Width = 505
        object GridExclusoesLalur: TcxGridCitel
          Left = 2
          Top = 19
          Width = 501
          Height = 84
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridExclusoesLalurTableView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsExclusoesLalur
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridExclusoesLalurTableViewNAT_CODIGO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'NAT_CODIGO'
            end
            object GridExclusoesLalurTableViewNAT_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'NAT_DESCRI'
              Width = 250
            end
            object GridExclusoesLalurTableViewNAT_VALRES: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'NAT_VALRES'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 100
            end
            object GridExclusoesLalurTableViewCREDEB: TcxGridDBColumn
              Caption = 'D/C'
              DataBinding.FieldName = 'CREDEB'
              Width = 70
            end
          end
          object GridExclusoesLalurLevel1: TcxGridLevel
            GridView = GridExclusoesLalurTableView
          end
        end
      end
      object gbCompensacoesLalur: TcxGroupBox
        Left = 2
        Top = 420
        Caption = 'Compensa'#231#245'es (Resumo)'
        TabOrder = 10
        Height = 105
        Width = 505
        object GridCompensacoesLalur: TcxGridCitel
          Left = 2
          Top = 19
          Width = 501
          Height = 84
          Align = alClient
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridCompensacoesLalurTableView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            DataController.DataSource = dsCompensacoesLalur
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsCustomize.ColumnGrouping = False
            OptionsCustomize.ColumnMoving = False
            OptionsCustomize.ColumnSorting = False
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridCompensacoesLalurTableViewNAT_CODIGO: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'NAT_CODIGO'
              Visible = False
              VisibleForCustomization = False
            end
            object GridCompensacoesLalurTableViewNAT_DESCRI: TcxGridDBColumn
              Caption = 'Descri'#231#227'o'
              DataBinding.FieldName = 'NAT_DESCRI'
              Width = 250
            end
            object GridCompensacoesLalurTableViewNAT_VALRES: TcxGridDBColumn
              Caption = 'Valor'
              DataBinding.FieldName = 'NAT_VALRES'
              PropertiesClassName = 'TcxCalcEditProperties'
              Properties.DisplayFormat = '#,##0.00'
              Width = 100
            end
          end
          object GridCompensacoesLalurLevel1: TcxGridLevel
            GridView = GridCompensacoesLalurTableView
          end
        end
      end
    end
  end
  object dsAdicoesLacs: TDataSource
    AutoEdit = False
    Left = 440
    Top = 8
  end
  object dsExclusoesLacs: TDataSource
    AutoEdit = False
    Left = 440
    Top = 56
  end
  object dsCompensacoesLacs: TDataSource
    AutoEdit = False
    Left = 440
    Top = 104
  end
  object dsAdicoesLalur: TDataSource
    AutoEdit = False
    Left = 344
    Top = 16
  end
  object dsExclusoesLalur: TDataSource
    AutoEdit = False
    Left = 344
    Top = 64
  end
  object dsCompensacoesLalur: TDataSource
    AutoEdit = False
    Left = 344
    Top = 112
  end
end
