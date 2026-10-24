inherited frmPlanoContaVinculoPlanoReferencial: TfrmPlanoContaVinculoPlanoReferencial
  Width = 1141
  Height = 585
  Caption = 'Vinculos com o Plano de Contas Cont'#225'bil'
  Position = poMainFormCenter
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 1141
  ExplicitHeight = 585
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 512
    Width = 1135
    ExplicitTop = 512
    ExplicitWidth = 1135
    inherited FlwBotoes: TFlowPanel
      Width = 1131
      ExplicitWidth = 1131
      object btnSalvar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 90
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[F10] Salvar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF97433F97433FB59A9BB59A9BB59A9BB5
          9A9BB59A9BB59A9BB59A9B93303097433FFF00FFFF00FFFF00FFFF00FF97433F
          D66868C66060E5DEDF92292A92292AE4E7E7E0E3E6D9DFE0CCC9CC8F201FAF46
          4697433FFF00FFFF00FFFF00FF97433FD06566C25F5FE9E2E292292A92292AE2
          E1E3E2E6E8DDE2E4CFCCCF8F2222AD464697433FFF00FFFF00FFFF00FF97433F
          D06565C15D5DECE4E492292A92292ADFDDDFE1E6E8E0E5E7D3D0D28A1E1EAB44
          4497433FFF00FFFF00FFFF00FF97433FD06565C15B5CEFE6E6EDE5E5E5DEDFE0
          DDDFDFE0E2E0E1E3D6D0D2962A2AB24A4A97433FFF00FFFF00FFFF00FF97433F
          CD6263C86060C96767CC7272CA7271C66969C46464CC6D6CCA6667C55D5DCD65
          6597433FFF00FFFF00FFFF00FF97433FB65553C27B78D39D9CD7A7A5D8A7A6D8
          A6A5D7A09FD5A09FD7A9A7D8ABABCC666797433FFF00FFFF00FFFF00FF97433F
          CC6667F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC66
          6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
          F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
          CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
          6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
          F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
          CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
          6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
          F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FFFF00FF
          97433FF9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F99743
          3FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 0
        Visible = False
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1055
      ExplicitLeft = 1055
    end
  end
  inherited pnlStatus: TPanel
    Top = 540
    Width = 1135
    ExplicitTop = 540
    ExplicitWidth = 1135
    inherited pnlNomeForm: TPanel
      Left = 964
      ExplicitLeft = 964
    end
    inherited pnlInfo: TPanel
      Width = 964
      ExplicitWidth = 964
    end
  end
  object pgVinculo: TPageControl [2]
    Left = 0
    Top = 0
    Width = 1135
    Height = 512
    ActivePage = tsPlanoReferencial
    Align = alClient
    Style = tsFlatButtons
    TabOrder = 2
    OnChanging = pgVinculoChanging
    object tsPlanoReferencial: TTabSheet
      Caption = '&1 - Plano Referencial'
      object pnlBotoesPlanoReferencial: TPanel
        Left = 0
        Top = 450
        Width = 1127
        Height = 30
        Align = alBottom
        TabOrder = 0
        object btnSalvarPlanoReferencial: TBitBtnLocked
          Left = 7
          Top = 4
          Width = 90
          Height = 22
          Caption = '[F10] S&alvar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF97433F97433FB59A9BB59A9BB59A9BB5
            9A9BB59A9BB59A9BB59A9B93303097433FFF00FFFF00FFFF00FFFF00FF97433F
            D66868C66060E5DEDF92292A92292AE4E7E7E0E3E6D9DFE0CCC9CC8F201FAF46
            4697433FFF00FFFF00FFFF00FF97433FD06566C25F5FE9E2E292292A92292AE2
            E1E3E2E6E8DDE2E4CFCCCF8F2222AD464697433FFF00FFFF00FFFF00FF97433F
            D06565C15D5DECE4E492292A92292ADFDDDFE1E6E8E0E5E7D3D0D28A1E1EAB44
            4497433FFF00FFFF00FFFF00FF97433FD06565C15B5CEFE6E6EDE5E5E5DEDFE0
            DDDFDFE0E2E0E1E3D6D0D2962A2AB24A4A97433FFF00FFFF00FFFF00FF97433F
            CD6263C86060C96767CC7272CA7271C66969C46464CC6D6CCA6667C55D5DCD65
            6597433FFF00FFFF00FFFF00FF97433FB65553C27B78D39D9CD7A7A5D8A7A6D8
            A6A5D7A09FD5A09FD7A9A7D8ABABCC666797433FFF00FFFF00FFFF00FF97433F
            CC6667F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC66
            6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
            F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
            CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
            6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
            F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
            CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
            6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
            F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FFFF00FF
            97433FF9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F99743
            3FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 0
          OnClick = btnSalvarPlanoReferencialClick
        end
      end
      object gbPlanoContas: TcxGroupBox
        Left = 0
        Top = 0
        Align = alLeft
        Caption = 'Plano de Contas Cont'#225'bil'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 16
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 1
        Height = 450
        Width = 817
        object GridPlanoContas: TcxGridCitel
          Left = 2
          Top = 21
          Width = 813
          Height = 427
          ParentCustomHint = False
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridPlanoContasView: TcxGridDBBandedTableView
            Navigator.Buttons.CustomButtons = <>
            FindPanel.DisplayMode = fpdmAlways
            FindPanel.InfoText = 'Tecle Enter para Pesquisar...'
            FindPanel.ShowClearButton = False
            FindPanel.ShowFindButton = False
            OnEditing = GridPlanoContasViewEditing
            DataController.DataSource = dsPlanoContas
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FixedDataRows.PinClickAction = rpcaFixToTop
            FixedDataRows.PinVisibility = rpvHotTrack
            FixedDataRows.SeparatorWidth = 10
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Bands = <
              item
                Width = 870
              end>
            object GridPlanoContasViewAUTOINCREM: TcxGridDBBandedColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
              VisibleForCustomization = False
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object GridPlanoContasViewNCO_CODCON: TcxGridDBBandedColumn
              Caption = 'C'#243'digo Plano Contas'
              DataBinding.FieldName = 'NCO_CODCON'
              PropertiesClassName = 'TcxMaskEditProperties'
              Options.Editing = False
              Width = 113
              Position.BandIndex = 0
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object GridPlanoContasViewNCO_DESCRI: TcxGridDBBandedColumn
              Caption = 'Descri'#231#227'o Plano Contas'
              DataBinding.FieldName = 'NCO_DESCRI'
              Options.Editing = False
              Width = 185
              Position.BandIndex = 0
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object GridPlanoContasViewSELECIONADO: TcxGridDBBandedColumn
              Caption = 'Selecionado'
              DataBinding.FieldName = 'SELECIONADO'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              MinWidth = 50
              Options.FilteringWithFindPanel = False
              Options.IncSearch = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 50
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object GridPlanoContasViewNCO_CTAREF: TcxGridDBBandedColumn
              Caption = 'C'#243'digo Plano Referencial'
              DataBinding.FieldName = 'NCO_CTAREF'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Default = True
                  Glyph.SourceDPI = 96
                  Glyph.Data = {
                    89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                    61000002AF49444154785EA5925B48545B1CC6879A3D7BF6DE7343CC4B264297
                    635A074D6D26B538A6354E6299E6A5330E39929A8E664A8E3992860347B31823
                    A51B68133DC8143D08611A9AE23D1CCC1B5ED2D0A2A85E7B08B3D4AFB53B5B1F
                    82ECA105BF87FDC1FFF7B1F67F8900FC11AB6723414260042821A3094A822BC1
                    85C0F2F9CF022A2AA5C014AD3FDFA535142F44269DEBDD17633493DC3DE490DE
                    127634D3792021EF8B4697FE6277F831AB205B9388A292F3732FDF68FCD6D13B
                    8477EF3FA2BDDB898A1AFB92FA485A4BF9D5FAA527ED7D7835F71A8F9F76A3E4
                    BF9BCB3B35BA2A2250AC09B4A4B9A36F08D63A07F48536249FAD46A2A912C733
                    2B109B5E06DD290B0EFD5B841C8B0D4D2D9D0838983241045E6B82C37AF302DF
                    9C9C5F8D86FB0EC46759C19F89E9190C8F8E419B6A46B5AD0EA147B330393D8B
                    105DDA57220822287F08FE3991D7DFD63588D22B76A1B10487496344623E4263
                    4F43EFAFC6191F5F9CCC34A3F1513376046BE74D2C3B90C6320DB3419C48A48E
                    36145FB2DD5D6AEDECC7DC9BB7686EEF4169D5EDE55DE171034591BA9567812E
                    B06F51A13C588D2463EE8A51E5F2E18E9B1CAD5B395859AE90DF82223022F1A2
                    26C638141697BD18AC358CF869622A49BED7B4C963FE9EB70A53FB55A8F754A0
                    58265FE487270264B8E5CAA18C61EDBC60038115D6E3457027C885ECEF5C4EE6
                    6C20C3536A051EF8C83119F8FFB091960ECFF84945BF7B651C21D2C2C93E3D24
                    C3B3413238367328A099CF248F9FF98BFEB540788DBE390C3B78C74D419A3938
                    BC388CFB33A8554A914A49465F6E93AC2B70CD63B91EFECE93C29D0BA4CCE7EB
                    4A06E3DB695C93D328A224F67505D92CDBD6B2955BBDF308C91252296AAC860C
                    37B951B820A16AD71348087E198CB42383963E2741004141D863108B9D7A31D5
                    3DED2DFEED4F94085BF120D04246133C79F8EFEF6BABDB90CF7763F500000000
                    49454E44AE426082}
                  Hint = 'Remover Vinculo do Plano Referencial'
                  Kind = bkGlyph
                end>
              Properties.ReadOnly = True
              Properties.OnButtonClick = GridPlanoContasViewNCO_CTAREFPropertiesButtonClick
              Options.ShowEditButtons = isebAlways
              Width = 123
              Position.BandIndex = 0
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
            object GridPlanoContasViewNRE_DESCRI: TcxGridDBBandedColumn
              Caption = 'Descri'#231#227'o Plano Referencial'
              DataBinding.FieldName = 'NRE_DESCRI'
              Options.Editing = False
              Width = 279
              Position.BandIndex = 0
              Position.ColIndex = 5
              Position.RowIndex = 0
            end
          end
          object GridPlanoContasLevel: TcxGridLevel
            GridView = GridPlanoContasView
          end
        end
      end
      object gbPlanoReferencial: TcxGroupBox
        Left = 817
        Top = 0
        Align = alClient
        Caption = 'Plano Referencial'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 16
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 2
        Height = 450
        Width = 310
        object GridPlanoReferencial: TcxGridCitel
          Left = 2
          Top = 21
          Width = 306
          Height = 427
          ParentCustomHint = False
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridPlanoReferencialView: TcxGridDBBandedTableView
            Navigator.Buttons.CustomButtons = <>
            FindPanel.DisplayMode = fpdmAlways
            FindPanel.InfoText = 'Tecle Enter para Pesquisar...'
            FindPanel.ShowClearButton = False
            FindPanel.ShowFindButton = False
            DataController.DataSource = dsPlanoReferencial
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Bands = <
              item
                Width = 651
              end>
            object GridPlanoReferencialViewNRE_CODREF: TcxGridDBBandedColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'NRE_CODREF'
              Options.Editing = False
              Width = 89
              Position.BandIndex = 0
              Position.ColIndex = 1
              Position.RowIndex = 0
            end
            object GridPlanoReferencialViewNRE_DESCRI: TcxGridDBBandedColumn
              Caption = 'Descri'#231#227'o Plano Referencial'
              DataBinding.FieldName = 'NRE_DESCRI'
              Options.Editing = False
              Width = 202
              Position.BandIndex = 0
              Position.ColIndex = 2
              Position.RowIndex = 0
            end
            object GridPlanoReferencialViewSELECIONADO: TcxGridDBBandedColumn
              Caption = 'Selecionado'
              DataBinding.FieldName = 'SELECIONADO'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Caption = 'Vincular Plano de Contas'
                  ContentAlignment = taLeftJustify
                  Default = True
                  Kind = bkText
                  LeftAlignment = True
                end>
              Properties.OnButtonClick = GridPlanoReferencialViewSELECIONADOPropertiesButtonClick
              MinWidth = 132
              Options.Filtering = False
              Options.FilteringWithFindPanel = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Options.ShowEditButtons = isebAlways
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Options.VertSizing = False
              Width = 132
              Position.BandIndex = 0
              Position.ColIndex = 0
              Position.RowIndex = 0
            end
            object GridPlanoReferencialViewNRE_DTAINI: TcxGridDBBandedColumn
              Caption = 'Vig'#234'ncia Inicial'
              DataBinding.FieldName = 'NRE_DTAINI'
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 3
              Position.RowIndex = 0
            end
            object GridPlanoReferencialViewNRE_DTAFIN: TcxGridDBBandedColumn
              Caption = 'Vig'#234'ncia Final'
              DataBinding.FieldName = 'NRE_DTAFIN'
              Options.Editing = False
              Position.BandIndex = 0
              Position.ColIndex = 4
              Position.RowIndex = 0
            end
          end
          object GridPlanoReferencialLevel: TcxGridLevel
            GridView = GridPlanoReferencialView
          end
        end
      end
    end
    object tsPlanoContasFinanceiro: TTabSheet
      Caption = '&2 - Plano de Contas Financeiro'
      ImageIndex = 1
      object pnlBotoesPlanoContasFinanceiro: TPanel
        Left = 0
        Top = 450
        Width = 1127
        Height = 30
        Align = alBottom
        TabOrder = 0
        object btnSalvarPlanoContasFinanceiro: TBitBtnLocked
          Left = 7
          Top = 4
          Width = 90
          Height = 22
          Caption = '[F10] S&alvar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF97433F97433FB59A9BB59A9BB59A9BB5
            9A9BB59A9BB59A9BB59A9B93303097433FFF00FFFF00FFFF00FFFF00FF97433F
            D66868C66060E5DEDF92292A92292AE4E7E7E0E3E6D9DFE0CCC9CC8F201FAF46
            4697433FFF00FFFF00FFFF00FF97433FD06566C25F5FE9E2E292292A92292AE2
            E1E3E2E6E8DDE2E4CFCCCF8F2222AD464697433FFF00FFFF00FFFF00FF97433F
            D06565C15D5DECE4E492292A92292ADFDDDFE1E6E8E0E5E7D3D0D28A1E1EAB44
            4497433FFF00FFFF00FFFF00FF97433FD06565C15B5CEFE6E6EDE5E5E5DEDFE0
            DDDFDFE0E2E0E1E3D6D0D2962A2AB24A4A97433FFF00FFFF00FFFF00FF97433F
            CD6263C86060C96767CC7272CA7271C66969C46464CC6D6CCA6667C55D5DCD65
            6597433FFF00FFFF00FFFF00FF97433FB65553C27B78D39D9CD7A7A5D8A7A6D8
            A6A5D7A09FD5A09FD7A9A7D8ABABCC666797433FFF00FFFF00FFFF00FF97433F
            CC6667F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC66
            6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
            F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
            CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
            6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
            F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
            CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
            6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
            F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FFFF00FF
            97433FF9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F99743
            3FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 0
          OnClick = btnSalvarPlanoContasFinanceiroClick
        end
      end
      object gbPlanoContabilPlanoContasFinanceiro: TcxGroupBox
        Left = 817
        Top = 0
        Align = alClient
        Caption = 'Plano de Contas Cont'#225'bil'
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = 16
        Style.Font.Name = 'Tahoma'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 1
        Height = 450
        Width = 310
        object GridPlanoContabilFinanceiro: TcxGridCitel
          Left = 2
          Top = 21
          Width = 306
          Height = 427
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridPlanoContabilFinanceiroView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            FindPanel.DisplayMode = fpdmAlways
            FindPanel.ShowClearButton = False
            FindPanel.ShowFindButton = False
            DataController.DataSource = dsPlancoContasFinanceiro
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridPlanoContabilFinanceiroViewSELECIONADO: TcxGridDBColumn
              Caption = 'Selecionado'
              DataBinding.FieldName = 'SELECIONADO'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Caption = 'Vincular Conta Cont'#225'bil'
                  ContentAlignment = taLeftJustify
                  Default = True
                  Kind = bkText
                  LeftAlignment = True
                end>
              Properties.OnButtonClick = GridPlanoContabilFinanceiroViewSELECIONADOPropertiesButtonClick
              MinWidth = 123
              Options.Filtering = False
              Options.FilteringWithFindPanel = False
              Options.IgnoreTimeForFiltering = False
              Options.IncSearch = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Options.ShowEditButtons = isebAlways
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Width = 123
            end
            object GridPlanoContabilFinanceiroViewNCO_CODCON: TcxGridDBColumn
              Caption = 'Conta Cont'#225'bil'
              DataBinding.FieldName = 'NCO_CODCON'
              Options.Editing = False
            end
            object GridPlanoContabilFinanceiroViewNCO_DESCRI: TcxGridDBColumn
              Caption = 'Descr.Conta Cont'#225'bil'
              DataBinding.FieldName = 'NCO_DESCRI'
              Options.Editing = False
              Width = 382
            end
            object GridPlanoContabilFinanceiroViewNCO_DTAINI: TcxGridDBColumn
              Caption = 'Vig.Inicial'
              DataBinding.FieldName = 'NCO_DTAINI'
              Options.Editing = False
              Width = 110
            end
            object GridPlanoContabilFinanceiroViewNCO_DTAFIN: TcxGridDBColumn
              Caption = 'Vig.Final'
              DataBinding.FieldName = 'NCO_DTAFIN'
              Options.Editing = False
              Width = 119
            end
            object GridPlanoContabilFinanceiroViewAUTOINCREM: TcxGridDBColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object GridPlanoContabilFinanceiroLevel: TcxGridLevel
            GridView = GridPlanoContabilFinanceiroView
          end
        end
      end
      object gbPlanoContasFinanceiro: TcxGroupBox
        Left = 0
        Top = 0
        Align = alLeft
        Caption = 'Plano de Contas Financeiro'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 16
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 2
        Height = 450
        Width = 817
        object GridPlanoContasFinanceiro: TcxGridCitel
          Left = 2
          Top = 21
          Width = 813
          Height = 427
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridPlanoContasFinanceiroView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            FindPanel.DisplayMode = fpdmAlways
            FindPanel.ShowClearButton = False
            FindPanel.ShowFindButton = False
            OnEditing = GridPlanoContasFinanceiroViewEditing
            DataController.DataSource = dsPlanoContasFinanceiro
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            FixedDataRows.PinClickAction = rpcaFixToTop
            FixedDataRows.PinVisibility = rpvHotTrack
            FixedDataRows.SeparatorWidth = 10
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridPlanoContasFinanceiroViewSELECIONADO: TcxGridDBColumn
              Caption = 'Sel. Conta'
              DataBinding.FieldName = 'SELECIONADO'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              MinWidth = 49
              Options.FilteringWithFindPanel = False
              Options.IgnoreTimeForFiltering = False
              Options.IncSearch = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Width = 49
            end
            object GridPlanoContasFinanceiroViewPOR_EMPRESA: TcxGridDBColumn
              Caption = 'Empresa'
              DataBinding.FieldName = 'POR_EMPRESA'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              MinWidth = 78
              Options.Editing = False
              Options.FilteringWithFindPanel = False
              Options.IgnoreTimeForFiltering = False
              Options.IncSearch = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Width = 78
            end
            object GridPlanoContasFinanceiroViewVER_EMPRESA: TcxGridDBColumn
              DataBinding.FieldName = 'VER_EMPRESA'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  ContentAlignment = taLeftJustify
                  Default = True
                  Glyph.SourceDPI = 96
                  Glyph.Data = {
                    89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                    610000000F744558745469746C650053686F773B4579653B49E30725000002AA
                    49444154785EC5936B48D35D1CC7FF96F6A20BCF33F2D2555A68E9449C824473
                    CED4294BDD4CE7749BC3DCCCA5957861920935F1DAC3349D159A4D9316EAB464
                    DE304186461219A5E19B82BCE4B4126FE85C378C6FFFFD99F4A2DEF5E239F039
                    2F0EDFDFE77738FC0E01E0AFF86BC19FD63692ED248E244E761CEDE70EBFA5EF
                    49FD099D9849155E0A3A42ABE67B67D7C67A19B57CAFF19BFCE39B37A23CC735
                    3C8FDED2707ABECCCFCDCD26AF8AA4139511F45F02EA50C0903425072E0F6BB3
                    F16EE02E165E1AB1F9E9053E3C6BC5447B057AAE49713396B156C03E2C26F33B
                    481C58D11A822AAE89F3C9E8574B611E694147CD1548F85CF0C238F064F88017
                    CA46228F83A6AB0A3C6F2C40B39CFDE372D0A1349B8412E4857AD09BE5ACEF0D
                    EA4CA4CA15607345B8D5D68DE1993904868AA15495A2A2FE01427862C8646751
                    9E2E8036CE0F72A62B9B7A1BADD0F77A5E9A0C4663379657D610169F8781D793
                    48C92A8277C06978911886C6102152E1BD7911FA960E284567A00E716F27053B
                    892CE985F70FBB0661B17C8665E32BCEA414E2B6C104456E198E3242204C55A1
                    5AFF1862651166E757303DBB04DDFD2E4823A573A4600F214AC8B95854D5870D
                    EB37AC5BBEE051CF3044E9C5286BE842DDC32728A933224EA186C1388469F312
                    2538AFD2E3E409713E7503BF83FF38474934BA7AFD083E2EAC6379D58AB6CE41
                    C424E5C297258120391FAD9D264CCD2E62E2CD3CCA6AFA11702ADFE0B2CBE900
                    352FF68DC6151697272A1BAD37EE98601A798BD1B119983FACE2E9E824FA0627
                    A0D6F4223CA1DACAE4E4D492F97DF601732012339AB724BBF7BBFB1F0B8E2E2C
                    09176A46C3849553DC442D3882FFA682A28A5F3183B32A68AEC77DC8DCBF248E
                    B619B0412465361309CA2622FE9C8EB08FEC4E7B682F890B893309CDD660AB2B
                    2BA692D812FCFFBFF12735D001EA49B1E4AE0000000049454E44AE426082}
                  Kind = bkGlyph
                  LeftAlignment = True
                end>
              Properties.OnButtonClick = GridPlanoContasFinanceiroViewVER_EMPRESAPropertiesButtonClick
              MinWidth = 24
              Options.Filtering = False
              Options.FilteringWithFindPanel = False
              Options.IgnoreTimeForFiltering = False
              Options.IncSearch = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Options.ShowEditButtons = isebAlways
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Width = 24
              IsCaptionAssigned = True
            end
            object GridPlanoContasFinanceiroViewCTA_CODCTA: TcxGridDBColumn
              Caption = 'Conta'
              DataBinding.FieldName = 'CTA_CODCTA'
              Options.Editing = False
            end
            object GridPlanoContasFinanceiroViewCTA_DESCTA: TcxGridDBColumn
              Caption = 'Descri'#231#227'o da Conta'
              DataBinding.FieldName = 'CTA_DESCTA'
              Options.Editing = False
              Width = 272
            end
            object GridPlanoContasFinanceiroViewCTA_PLANCO: TcxGridDBColumn
              Caption = 'Conta Cont'#225'bil'
              DataBinding.FieldName = 'CTA_PLANCO'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Default = True
                  Glyph.SourceDPI = 96
                  Glyph.Data = {
                    89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                    61000002AF49444154785EA5925B48545B1CC6879A3D7BF6DE7343CC4B264297
                    635A074D6D26B538A6354E6299E6A5330E39929A8E664A8E3992860347B31823
                    A51B68133DC8143D08611A9AE23D1CCC1B5ED2D0A2A85E7B08B3D4AFB53B5B1F
                    82ECA105BF87FDC1FFF7B1F67F8900FC11AB6723414260042821A3094A822BC1
                    85C0F2F9CF022A2AA5C014AD3FDFA535142F44269DEBDD17633493DC3DE490DE
                    127634D3792021EF8B4697FE6277F831AB205B9388A292F3732FDF68FCD6D13B
                    8477EF3FA2BDDB898A1AFB92FA485A4BF9D5FAA527ED7D7835F71A8F9F76A3E4
                    BF9BCB3B35BA2A2250AC09B4A4B9A36F08D63A07F48536249FAD46A2A912C733
                    2B109B5E06DD290B0EFD5B841C8B0D4D2D9D0838983241045E6B82C37AF302DF
                    9C9C5F8D86FB0EC46759C19F89E9190C8F8E419B6A46B5AD0EA147B330393D8B
                    105DDA57220822287F08FE3991D7DFD63588D22B76A1B10487496344623E4263
                    4F43EFAFC6191F5F9CCC34A3F1513376046BE74D2C3B90C6320DB3419C48A48E
                    36145FB2DD5D6AEDECC7DC9BB7686EEF4169D5EDE55DE171034591BA9567812E
                    B06F51A13C588D2463EE8A51E5F2E18E9B1CAD5B395859AE90DF82223022F1A2
                    26C638141697BD18AC358CF869622A49BED7B4C963FE9EB70A53FB55A8F754A0
                    58265FE487270264B8E5CAA18C61EDBC60038115D6E3457027C885ECEF5C4EE6
                    6C20C3536A051EF8C83119F8FFB091960ECFF84945BF7B651C21D2C2C93E3D24
                    C3B3413238367328A099CF248F9FF98BFEB540788DBE390C3B78C74D419A3938
                    BC388CFB33A8554A914A49465F6E93AC2B70CD63B91EFECE93C29D0BA4CCE7EB
                    4A06E3DB695C93D328A224F67505D92CDBD6B2955BBDF308C91252296AAC860C
                    37B951B820A16AD71348087E198CB42383963E2741004141D863108B9D7A31D5
                    3DED2DFEED4F94085BF120D04246133C79F8EFEF6BABDB90CF7763F500000000
                    49454E44AE426082}
                  Kind = bkGlyph
                end>
              Properties.ReadOnly = True
              Properties.OnButtonClick = GridPlanoContasFinanceiroViewCTA_PLANCOPropertiesButtonClick
              Options.ShowEditButtons = isebAlways
            end
            object GridPlanoContasFinanceiroViewNCO_DESCRI: TcxGridDBColumn
              Caption = 'Descr.Conta Cont'#225'bil'
              DataBinding.FieldName = 'NCO_DESCRI'
              Options.Editing = False
              Width = 406
            end
            object GridPlanoContasFinanceiroViewAUTOINCREM: TcxGridDBColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object GridPlanoContasFinanceiroLevel: TcxGridLevel
            GridView = GridPlanoContasFinanceiroView
          end
        end
      end
    end
    object tsPortador: TTabSheet
      Caption = '&3 - Portador'
      ImageIndex = 2
      object pnlBotoesPortador: TPanel
        Left = 0
        Top = 450
        Width = 1127
        Height = 30
        Align = alBottom
        TabOrder = 0
        object btnSalvarPortador: TBitBtnLocked
          Left = 7
          Top = 4
          Width = 90
          Height = 22
          Caption = '[F10] S&alvar'
          Glyph.Data = {
            36030000424D3603000000000000360000002800000010000000100000000100
            18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
            FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
            FFFF00FFFF00FFFF00FFFF00FFFF00FF97433F97433FB59A9BB59A9BB59A9BB5
            9A9BB59A9BB59A9BB59A9B93303097433FFF00FFFF00FFFF00FFFF00FF97433F
            D66868C66060E5DEDF92292A92292AE4E7E7E0E3E6D9DFE0CCC9CC8F201FAF46
            4697433FFF00FFFF00FFFF00FF97433FD06566C25F5FE9E2E292292A92292AE2
            E1E3E2E6E8DDE2E4CFCCCF8F2222AD464697433FFF00FFFF00FFFF00FF97433F
            D06565C15D5DECE4E492292A92292ADFDDDFE1E6E8E0E5E7D3D0D28A1E1EAB44
            4497433FFF00FFFF00FFFF00FF97433FD06565C15B5CEFE6E6EDE5E5E5DEDFE0
            DDDFDFE0E2E0E1E3D6D0D2962A2AB24A4A97433FFF00FFFF00FFFF00FF97433F
            CD6263C86060C96767CC7272CA7271C66969C46464CC6D6CCA6667C55D5DCD65
            6597433FFF00FFFF00FFFF00FF97433FB65553C27B78D39D9CD7A7A5D8A7A6D8
            A6A5D7A09FD5A09FD7A9A7D8ABABCC666797433FFF00FFFF00FFFF00FF97433F
            CC6667F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC66
            6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
            F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
            CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
            6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
            F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FF97433F
            CC6667F9F9F9CDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDCDF9F9F9CC66
            6797433FFF00FFFF00FFFF00FF97433FCC6667F9F9F9F9F9F9F9F9F9F9F9F9F9
            F9F9F9F9F9F9F9F9F9F9F9F9F9F9CC666797433FFF00FFFF00FFFF00FFFF00FF
            97433FF9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F9F99743
            3FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
            00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
          TabOrder = 0
          OnClick = btnSalvarPortadorClick
        end
      end
      object gbPlanoContabilPortador: TcxGroupBox
        Left = 817
        Top = 0
        Align = alClient
        Caption = 'Plano de Contas Cont'#225'bil'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 16
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 1
        Height = 450
        Width = 310
        object GridPlanoContabilPortadores: TcxGridCitel
          Left = 2
          Top = 21
          Width = 306
          Height = 427
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridPlanoContabilPortadoresView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            FindPanel.DisplayMode = fpdmAlways
            FindPanel.ShowClearButton = False
            FindPanel.ShowFindButton = False
            DataController.DataSource = dsPlancoPortador
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridPlanoContabilPortadoresViewSELECIONADO: TcxGridDBColumn
              Caption = 'Selecionado'
              DataBinding.FieldName = 'SELECIONADO'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Caption = 'Vincular Conta Cont'#225'bil'
                  ContentAlignment = taLeftJustify
                  Default = True
                  Kind = bkText
                  LeftAlignment = True
                end>
              Properties.OnButtonClick = GridPlanoContabilPortadoresViewSELECIONADOPropertiesButtonClick
              MinWidth = 123
              Options.Filtering = False
              Options.FilteringWithFindPanel = False
              Options.IncSearch = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Options.ShowEditButtons = isebAlways
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Width = 123
            end
            object GridPlanoContabilPortadoresViewNCO_CODCON: TcxGridDBColumn
              Caption = 'Conta Cont'#225'bil'
              DataBinding.FieldName = 'NCO_CODCON'
              Options.Editing = False
            end
            object GridPlanoContabilPortadoresViewNCO_DESCRI: TcxGridDBColumn
              Caption = 'Descr.Conta Cont'#225'bil'
              DataBinding.FieldName = 'NCO_DESCRI'
              Options.Editing = False
              Width = 382
            end
            object GridPlanoContabilPortadoresViewNCO_DTAINI: TcxGridDBColumn
              Caption = 'Vig.Inicial'
              DataBinding.FieldName = 'NCO_DTAINI'
              Options.Editing = False
              Width = 110
            end
            object GridPlanoContabilPortadoresViewNCO_DTAFIN: TcxGridDBColumn
              Caption = 'Vig.Final'
              DataBinding.FieldName = 'NCO_DTAFIN'
              Options.Editing = False
              Width = 119
            end
            object GridPlanoContabilPortadoresViewAUTOINCREM: TcxGridDBColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object GridPlanoContabilPortadoresLevel: TcxGridLevel
            GridView = GridPlanoContabilPortadoresView
          end
        end
      end
      object gbPortadores: TcxGroupBox
        Left = 0
        Top = 0
        Align = alLeft
        Caption = 'Portadores'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clBlack
        Style.Font.Height = 16
        Style.Font.Name = 'Arial'
        Style.Font.Pitch = fpVariable
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        TabOrder = 2
        Height = 450
        Width = 817
        object GridPortadores: TcxGridCitel
          Left = 2
          Top = 21
          Width = 813
          Height = 427
          Align = alClient
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          LookAndFeel.ScrollbarMode = sbmClassic
          object GridPortadoresView: TcxGridDBTableViewCitel
            Navigator.Buttons.CustomButtons = <>
            FindPanel.DisplayMode = fpdmAlways
            FindPanel.ShowClearButton = False
            FindPanel.ShowFindButton = False
            OnEditing = GridPortadoresViewEditing
            DataController.DataSource = dsPortadores
            DataController.Filter.Options = [fcoCaseInsensitive]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Clique aqui para definir um filtro'
            FilterRow.ApplyChanges = fracDelayed
            FixedDataRows.PinClickAction = rpcaFixToTop
            FixedDataRows.PinVisibility = rpvHotTrack
            FixedDataRows.SeparatorWidth = 10
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
            OptionsView.GroupByBox = False
            OptionsView.Indicator = True
            Zebra = False
            Destaque = False
            CorZebra = clMoneyGreen
            object GridPortadoresViewSELECIONADO: TcxGridDBColumn
              Caption = 'Sel. Portador'
              DataBinding.FieldName = 'SELECIONADO'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              MinWidth = 55
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Width = 55
            end
            object GridPortadoresViewPOR_EMPRESA: TcxGridDBColumn
              Caption = 'Empresa'
              DataBinding.FieldName = 'POR_EMPRESA'
              PropertiesClassName = 'TcxCheckBoxProperties'
              Properties.ValueChecked = '1'
              Properties.ValueUnchecked = '0'
              MinWidth = 78
              Options.Editing = False
              Options.IncSearch = False
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Width = 78
            end
            object GridPortadoresViewVER_EMPRESA: TcxGridDBColumn
              DataBinding.FieldName = 'VER_EMPRESA'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  ContentAlignment = taLeftJustify
                  Default = True
                  Glyph.SourceDPI = 96
                  Glyph.Data = {
                    89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                    610000000F744558745469746C650053686F773B4579653B49E30725000002AA
                    49444154785EC5936B48D35D1CC7FF96F6A20BCF33F2D2555A68E9449C824473
                    CED4294BDD4CE7749BC3DCCCA5957861920935F1DAC3349D159A4D9316EAB464
                    DE304186461219A5E19B82BCE4B4126FE85C378C6FFFFD99F4A2DEF5E239F039
                    2F0EDFDFE77738FC0E01E0AFF86BC19FD63692ED248E244E761CEDE70EBFA5EF
                    49FD099D9849155E0A3A42ABE67B67D7C67A19B57CAFF19BFCE39B37A23CC735
                    3C8FDED2707ABECCCFCDCD26AF8AA4139511F45F02EA50C0903425072E0F6BB3
                    F16EE02E165E1AB1F9E9053E3C6BC5447B057AAE49713396B156C03E2C26F33B
                    481C58D11A822AAE89F3C9E8574B611E694147CD1548F85CF0C238F064F88017
                    CA46228F83A6AB0A3C6F2C40B39CFDE372D0A1349B8412E4857AD09BE5ACEF0D
                    EA4CA4CA15607345B8D5D68DE1993904868AA15495A2A2FE01427862C8646751
                    9E2E8036CE0F72A62B9B7A1BADD0F77A5E9A0C4663379657D610169F8781D793
                    48C92A8277C06978911886C6102152E1BD7911FA960E284567A00E716F27053B
                    892CE985F70FBB0661B17C8665E32BCEA414E2B6C104456E198E3242204C55A1
                    5AFF1862651166E757303DBB04DDFD2E4823A573A4600F214AC8B95854D5870D
                    EB37AC5BBEE051CF3044E9C5286BE842DDC32728A933224EA186C1388469F312
                    2538AFD2E3E409713E7503BF83FF38474934BA7AFD083E2EAC6379D58AB6CE41
                    C424E5C297258120391FAD9D264CCD2E62E2CD3CCA6AFA11702ADFE0B2CBE900
                    352FF68DC6151697272A1BAD37EE98601A798BD1B119983FACE2E9E824FA0627
                    A0D6F4223CA1DACAE4E4D492F97DF601732012339AB724BBF7BBFB1F0B8E2E2C
                    09176A46C3849553DC442D3882FFA682A28A5F3183B32A68AEC77DC8DCBF248E
                    B619B0412465361309CA2622FE9C8EB08FEC4E7B682F890B893309CDD660AB2B
                    2BA692D812FCFFBFF12735D001EA49B1E4AE0000000049454E44AE426082}
                  Kind = bkGlyph
                  LeftAlignment = True
                end>
              Properties.OnButtonClick = GridPortadoresViewVER_EMPRESAPropertiesButtonClick
              MinWidth = 24
              Options.Filtering = False
              Options.FilteringWithFindPanel = False
              Options.IncSearch = False
              Options.FilteringAddValueItems = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Options.ShowEditButtons = isebAlways
              Options.GroupFooters = False
              Options.Grouping = False
              Options.HorzSizing = False
              Options.Moving = False
              Options.Sorting = False
              Width = 24
              IsCaptionAssigned = True
            end
            object GridPortadoresViewPOR_CODPOR: TcxGridDBColumn
              Caption = 'Portador'
              DataBinding.FieldName = 'POR_CODPOR'
              Options.Editing = False
            end
            object GridPortadoresViewPOR_NOMPOR: TcxGridDBColumn
              Caption = 'Descri'#231#227'o do Portador'
              DataBinding.FieldName = 'POR_NOMPOR'
              Options.Editing = False
              Options.ShowEditButtons = isebAlways
              Width = 272
            end
            object GridPortadoresViewPOR_PLANCO: TcxGridDBColumn
              Caption = 'Conta Cont'#225'bil'
              DataBinding.FieldName = 'POR_PLANCO'
              PropertiesClassName = 'TcxButtonEditProperties'
              Properties.Buttons = <
                item
                  Default = True
                  Glyph.SourceDPI = 96
                  Glyph.Data = {
                    89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
                    61000002AF49444154785EA5925B48545B1CC6879A3D7BF6DE7343CC4B264297
                    635A074D6D26B538A6354E6299E6A5330E39929A8E664A8E3992860347B31823
                    A51B68133DC8143D08611A9AE23D1CCC1B5ED2D0A2A85E7B08B3D4AFB53B5B1F
                    82ECA105BF87FDC1FFF7B1F67F8900FC11AB6723414260042821A3094A822BC1
                    85C0F2F9CF022A2AA5C014AD3FDFA535142F44269DEBDD17633493DC3DE490DE
                    127634D3792021EF8B4697FE6277F831AB205B9388A292F3732FDF68FCD6D13B
                    8477EF3FA2BDDB898A1AFB92FA485A4BF9D5FAA527ED7D7835F71A8F9F76A3E4
                    BF9BCB3B35BA2A2250AC09B4A4B9A36F08D63A07F48536249FAD46A2A912C733
                    2B109B5E06DD290B0EFD5B841C8B0D4D2D9D0838983241045E6B82C37AF302DF
                    9C9C5F8D86FB0EC46759C19F89E9190C8F8E419B6A46B5AD0EA147B330393D8B
                    105DDA57220822287F08FE3991D7DFD63588D22B76A1B10487496344623E4263
                    4F43EFAFC6191F5F9CCC34A3F1513376046BE74D2C3B90C6320DB3419C48A48E
                    36145FB2DD5D6AEDECC7DC9BB7686EEF4169D5EDE55DE171034591BA9567812E
                    B06F51A13C588D2463EE8A51E5F2E18E9B1CAD5B395859AE90DF82223022F1A2
                    26C638141697BD18AC358CF869622A49BED7B4C963FE9EB70A53FB55A8F754A0
                    58265FE487270264B8E5CAA18C61EDBC60038115D6E3457027C885ECEF5C4EE6
                    6C20C3536A051EF8C83119F8FFB091960ECFF84945BF7B651C21D2C2C93E3D24
                    C3B3413238367328A099CF248F9FF98BFEB540788DBE390C3B78C74D419A3938
                    BC388CFB33A8554A914A49465F6E93AC2B70CD63B91EFECE93C29D0BA4CCE7EB
                    4A06E3DB695C93D328A224F67505D92CDBD6B2955BBDF308C91252296AAC860C
                    37B951B820A16AD71348087E198CB42383963E2741004141D863108B9D7A31D5
                    3DED2DFEED4F94085BF120D04246133C79F8EFEF6BABDB90CF7763F500000000
                    49454E44AE426082}
                  Kind = bkGlyph
                end>
              Properties.ReadOnly = True
              Properties.OnButtonClick = GridPortadoresViewPOR_PLANCOPropertiesButtonClick
              Options.ShowEditButtons = isebAlways
            end
            object GridPortadoresViewNCO_DESCRI: TcxGridDBColumn
              Caption = 'Descr.Conta Cont'#225'bil'
              DataBinding.FieldName = 'NCO_DESCRI'
              Options.Editing = False
              Width = 406
            end
            object GridPortadoresViewAUTOINCREM: TcxGridDBColumn
              DataBinding.FieldName = 'AUTOINCREM'
              Visible = False
              VisibleForCustomization = False
            end
          end
          object GridPortadoresLevel: TcxGridLevel
            GridView = GridPortadoresView
          end
        end
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 64
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 256
    Top = 56
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 416
    Top = 16
  end
  object dsPlanoReferencial: TDataSource
    DataSet = cdsPlanre
    Left = 286
    Top = 112
  end
  object dsPlanoContas: TDataSource
    DataSet = cdsPlancoComPlanoReferencial
    Left = 286
    Top = 160
  end
  object GridPopupPlanco: TcxGridPopupMenu
    Grid = GridPlanoContas
    PopupMenus = <
      item
        HitTypes = [gvhtCell, gvhtColumnHeader]
        Index = 0
        PopupMenu = PopupMenuPlanco
      end>
    Left = 512
    Top = 32
  end
  object cxGridPopupPlanre: TcxGridPopupMenu
    Grid = GridPlanoReferencial
    PopupMenus = <>
    Left = 512
    Top = 80
  end
  object PopupMenuPlanco: TPopupMenu
    Left = 104
    Top = 304
    object Marcar1: TMenuItem
      Caption = 'Marcar'
      OnClick = Marcar1Click
    end
    object Desmarcar1: TMenuItem
      Caption = 'Desmarcar'
      OnClick = Desmarcar1Click
    end
  end
  object GridPopupPortadores: TcxGridPopupMenu
    Grid = GridPortadores
    PopupMenus = <>
    Left = 508
    Top = 124
  end
  object GridPopupPlanoContasFinanceiro: TcxGridPopupMenu
    Grid = GridPlanoContasFinanceiro
    PopupMenus = <>
    Left = 508
    Top = 172
  end
  object GridPopupPlancoPortadores: TcxGridPopupMenu
    Grid = GridPlanoContabilPortadores
    PopupMenus = <>
    Left = 508
    Top = 220
  end
  object GridPopupPlancoPlanoContasFinanceiro: TcxGridPopupMenu
    Grid = GridPlanoContabilFinanceiro
    PopupMenus = <>
    Left = 508
    Top = 268
  end
  object dsPortadores: TDataSource
    DataSet = cdsCadporComPlanoContabil
    Left = 284
    Top = 212
  end
  object dsPlanoContasFinanceiro: TDataSource
    DataSet = cdsCadctaComPlanoContabil
    Left = 284
    Top = 260
  end
  object dsPlancoPortador: TDataSource
    DataSet = cdsPlancoPortador
    Left = 284
    Top = 308
  end
  object dsPlancoContasFinanceiro: TDataSource
    DataSet = cdsPlancoContasFinanceiro
    Left = 284
    Top = 356
  end
  object cdsPlanre: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 679
    Top = 236
    object cdsPlanreSELECIONADO: TStringField
      FieldName = 'SELECIONADO'
    end
    object cdsPlanreNRE_CODREF: TStringField
      FieldName = 'NRE_CODREF'
    end
    object cdsPlanreNRE_DESCRI: TStringField
      FieldName = 'NRE_DESCRI'
      Size = 128
    end
    object cdsPlanreNRE_DTAINI: TDateField
      FieldName = 'NRE_DTAINI'
    end
    object cdsPlanreNRE_DTAFIN: TDateField
      FieldName = 'NRE_DTAFIN'
    end
  end
  object cdsPlancoComPlanoReferencial: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 679
    Top = 188
    object cdsPlancoComPlanoReferencialSELECIONADO: TStringField
      FieldName = 'SELECIONADO'
      Size = 1
    end
    object cdsPlancoComPlanoReferencialAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsPlancoComPlanoReferencialNCO_CODCON: TStringField
      FieldName = 'NCO_CODCON'
    end
    object cdsPlancoComPlanoReferencialNCO_DESCRI: TStringField
      FieldName = 'NCO_DESCRI'
      Size = 100
    end
    object cdsPlancoComPlanoReferencialNCO_CTAREF: TStringField
      FieldName = 'NCO_CTAREF'
    end
    object cdsPlancoComPlanoReferencialNRE_DESCRI: TStringField
      FieldName = 'NRE_DESCRI'
      Size = 128
    end
  end
  object cdsCadctaComPlanoContabil: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 815
    Top = 180
    object cdsCadctaComPlanoContabilSELECIONADO: TStringField
      FieldName = 'SELECIONADO'
      Size = 1
    end
    object cdsCadctaComPlanoContabilPOR_EMPRESA: TStringField
      FieldName = 'POR_EMPRESA'
      Size = 1
    end
    object cdsCadctaComPlanoContabilCTA_CODCTA: TStringField
      FieldName = 'CTA_CODCTA'
    end
    object cdsCadctaComPlanoContabilCTA_DESCTA: TStringField
      FieldName = 'CTA_DESCTA'
      Size = 40
    end
    object cdsCadctaComPlanoContabilCTA_PLANCO: TStringField
      FieldName = 'CTA_PLANCO'
    end
    object cdsCadctaComPlanoContabilNCO_DESCRI: TStringField
      FieldName = 'NCO_DESCRI'
      Size = 100
    end
    object cdsCadctaComPlanoContabilAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsCadctaComPlanoContabilVER_EMPRESA: TStringField
      FieldName = 'VER_EMPRESA'
      Size = 1
    end
  end
  object cdsPlancoContasFinanceiro: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 815
    Top = 228
    object cdsPlancoContasFinanceiroSELECIONADO: TStringField
      FieldName = 'SELECIONADO'
      Size = 1
    end
    object cdsPlancoContasFinanceiroNCO_CODCON: TStringField
      FieldName = 'NCO_CODCON'
    end
    object cdsPlancoContasFinanceiroNCO_DESCRI: TStringField
      FieldName = 'NCO_DESCRI'
      Size = 100
    end
    object cdsPlancoContasFinanceiroNCO_DTAINI: TDateField
      FieldName = 'NCO_DTAINI'
    end
    object cdsPlancoContasFinanceiroNCO_DTAFIN: TDateField
      FieldName = 'NCO_DTAFIN'
    end
    object cdsPlancoContasFinanceiroAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
  object cdsCtanco: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'IndiceOrdenacao'
        Fields = 'CODEMP;CODCON'
      end
      item
        Name = 'IndicePesquisaCta'
        Fields = 'NCO_CODCTA'
      end>
    IndexName = 'IndiceOrdenacao'
    Params = <>
    StoreDefs = True
    Left = 815
    Top = 276
    object cdsCtancoNCO_CODCTA: TStringField
      FieldName = 'NCO_CODCTA'
    end
    object cdsCtancoCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsCtancoCODCON: TStringField
      FieldName = 'CODCON'
    end
    object cdsCtancoCONMSK: TStringField
      FieldName = 'CONMSK'
      Size = 100
    end
    object cdsCtancoCREDEB: TStringField
      FieldName = 'CREDEB'
      Size = 1
    end
  end
  object cdsCadporComPlanoContabil: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 959
    Top = 180
    object cdsCadporComPlanoContabilSELECIONADO: TStringField
      FieldName = 'SELECIONADO'
      Size = 1
    end
    object cdsCadporComPlanoContabilPOR_EMPRESA: TStringField
      FieldName = 'POR_EMPRESA'
      Size = 1
    end
    object cdsCadporComPlanoContabilPOR_CODPOR: TStringField
      FieldName = 'POR_CODPOR'
    end
    object cdsCadctaComPlanoContabilPOR_NOMPOR: TStringField
      FieldName = 'POR_NOMPOR'
      Size = 50
    end
    object cdsCadporComPlanoContabilPOR_PLANCO: TStringField
      FieldName = 'POR_PLANCO'
    end
    object cdsCadporComPlanoContabilNCO_DESCRI: TStringField
      FieldName = 'NCO_DESCRI'
      Size = 100
    end
    object cdsCadporComPlanoContabilAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
    object cdsCadporComPlanoContabilVER_EMPRESA: TStringField
      FieldName = 'VER_EMPRESA'
      Size = 1
    end
  end
  object cdsPlancoPortador: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 959
    Top = 228
    object cdsPlancoPortadorSELECIONADO: TStringField
      FieldName = 'SELECIONADO'
      Size = 1
    end
    object cdsPlancoPortadorNCO_CODCON: TStringField
      FieldName = 'NCO_CODCON'
    end
    object cdsPlancoPortadorNCO_DESCRI: TStringField
      FieldName = 'NCO_DESCRI'
      Size = 100
    end
    object cdsPlancoPortadorNCO_DTAINI: TDateField
      FieldName = 'NCO_DTAINI'
    end
    object cdsPlancoPortadorNCO_DTAFIN: TDateField
      FieldName = 'NCO_DTAFIN'
    end
    object cdsPlancoPortadorAUTOINCREM: TStringField
      FieldName = 'AUTOINCREM'
    end
  end
  object cdsPornco: TUniClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'IndiceOrdenacao'
        Fields = 'CODEMP;CODCON'
      end
      item
        Name = 'IndicePesquisa'
        Fields = 'NCO_CODPOR'
      end>
    IndexName = 'IndiceOrdenacao'
    Params = <>
    StoreDefs = True
    Left = 959
    Top = 276
    object cdsPorncoNCO_CODPOR: TStringField
      FieldName = 'NCO_CODPOR'
    end
    object cdsPorncoCODEMP: TStringField
      FieldName = 'CODEMP'
      Size = 3
    end
    object cdsPorncoCODCON: TStringField
      FieldName = 'CODCON'
    end
    object cdsPorncoCONMSK: TStringField
      FieldName = 'CONMSK'
      Size = 100
    end
    object cdsPorncoCREDEB: TStringField
      FieldName = 'CREDEB'
      Size = 1
    end
  end
end
