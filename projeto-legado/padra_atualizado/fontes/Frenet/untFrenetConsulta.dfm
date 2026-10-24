inherited frmFrenetConsulta: TfrmFrenetConsulta
  Left = 0
  Top = 0
  Width = 920
  Height = 927
  Caption = 'Consulta de Frete pela Frenet'
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 920
  ExplicitHeight = 927
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 852
    Width = 914
    Height = 30
    Enabled = True
    Visible = True
    ExplicitTop = 852
    ExplicitWidth = 914
    ExplicitHeight = 30
    inherited FlwBotoes: TFlowPanel
      Width = 631
      Height = 26
      Align = alLeft
      ExplicitWidth = 631
      ExplicitHeight = 26
      object btnFrenetOk: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 80
        Height = 25
        Align = alLeft
        Caption = 'FRENET'
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
        TabOrder = 0
        OnClick = btnFrenetOkClick
      end
      object btnQualpOk: TBitBtnLocked
        Left = 80
        Top = 0
        Width = 80
        Height = 25
        Align = alLeft
        Caption = 'QUALP'
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
        OnClick = btnQualpOkClick
      end
      object btnDataFrete: TBitBtnLocked
        Left = 160
        Top = 0
        Width = 105
        Height = 25
        Align = alLeft
        Caption = 'DATAFRETE'
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
        TabOrder = 4
        OnClick = btnDataFreteClick
      end
      object btnIntelipost: TBitBtnLocked
        Left = 265
        Top = 0
        Width = 105
        Height = 25
        Align = alLeft
        Caption = 'INTELIPOST'
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
        TabOrder = 5
        OnClick = btnIntelipostClick
      end
      object btnCancelar: TBitBtnLocked
        Left = 370
        Top = 0
        Width = 81
        Height = 25
        Align = alRight
        Cancel = True
        Caption = 'Cancelar'
        Glyph.Data = {
          DE010000424DDE01000000000000760000002800000024000000120000000100
          0400000000006801000000000000000000001000000000000000000000000000
          80000080000000808000800000008000800080800000C0C0C000808080000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333333333000033338833333333333333333F333333333333
          0000333911833333983333333388F333333F3333000033391118333911833333
          38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
          911118111118333338F3338F833338F3000033333911111111833333338F3338
          3333F8330000333333911111183333333338F333333F83330000333333311111
          8333333333338F3333383333000033333339111183333333333338F333833333
          00003333339111118333333333333833338F3333000033333911181118333333
          33338333338F333300003333911183911183333333383338F338F33300003333
          9118333911183333338F33838F338F33000033333913333391113333338FF833
          38F338F300003333333333333919333333388333338FFF830000333333333333
          3333333333333333333888330000333333333333333333333333333333333333
          0000}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnSairClick
      end
      object btnConfirmar: TBitBtnLocked
        Left = 451
        Top = 0
        Width = 104
        Height = 25
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
        OnClick = btnConfirmarClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 912
      Top = 2
      Width = 0
      Height = 26
      Align = alRight
      ExplicitLeft = 912
      ExplicitTop = 2
      ExplicitWidth = 0
      ExplicitHeight = 26
    end
  end
  inherited pnlStatus: TPanel
    Top = 882
    Width = 914
    ExplicitTop = 882
    ExplicitWidth = 914
    inherited pnlNomeForm: TPanel
      Left = 743
      ExplicitLeft = 743
    end
    inherited pnlInfo: TPanel
      Width = 743
      ExplicitWidth = 743
    end
  end
  inherited pgcDados: TPageControl
    Width = 914
    Height = 818
    ActivePage = tsTransportadoras
    ExplicitWidth = 914
    ExplicitHeight = 818
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 906
      ExplicitHeight = 560
    end
    object tsTransportadoras: TTabSheet
      Caption = 'tsTransportadoras'
      ImageIndex = 1
      TabVisible = False
      object pnlQualP: TPanel
        Left = 0
        Top = 280
        Width = 906
        Height = 91
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
      end
      object pnlFrenet: TPanel
        Left = 0
        Top = 0
        Width = 906
        Height = 280
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object gpbFrenet: TGroupBox
          Left = 0
          Top = 0
          Width = 906
          Height = 280
          Align = alClient
          Caption = 'Frenet'
          TabOrder = 0
          object cxGridCitel1: TcxGridCitel
            Left = 2
            Top = 56
            Width = 902
            Height = 222
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel
              Navigator.Buttons.CustomButtons = <>
              OnCustomDrawCell = cxGridCitel1DBTableViewCitel1CustomDrawCell
              DataController.DataSource = dtsFrenet
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsSelection.CellSelect = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn
                Caption = 'C'#243'digo Transportadora'
                DataBinding.FieldName = 'TRA_CODTRA'
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 127
              end
              object cxGridCitel1DBTableViewCitel1Column2: TcxGridDBColumn
                Caption = 'Nome Transportadora'
                DataBinding.FieldName = 'TRA_NOMTRA'
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 267
              end
              object cxGridCitel1DBTableViewCitel1Column3: TcxGridDBColumn
                Caption = 'Quantidade de Dias '#218'teis para Entrega'
                DataBinding.FieldName = 'TRA_DIAENT'
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 195
              end
              object cxGridCitel1DBTableViewCitel1Column4: TcxGridDBColumn
                Caption = 'Valor do Frete'
                DataBinding.FieldName = 'TRA_VLRFRE'
                HeaderAlignmentHorz = taCenter
                Width = 114
              end
              object cxGridCitel1DBTableViewCitel1Column5: TcxGridDBColumn
                Caption = 'Motivo da Indisponibilidade'
                DataBinding.FieldName = 'TRA_MSGERR'
                HeaderAlignmentHorz = taCenter
                Width = 183
              end
              object ERROR_: TcxGridDBColumn
                DataBinding.FieldName = 'TRA_ERROR_'
                Visible = False
              end
            end
            object cxGridCitel1Level1: TcxGridLevel
              GridView = cxGridCitel1DBTableViewCitel1
            end
          end
          object Panel2: TPanel
            Left = 2
            Top = 15
            Width = 902
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object lblCepDeEntrega: TLabel
              Left = 16
              Top = 14
              Width = 82
              Height = 13
              Caption = 'CEP de Entrega: '
            end
            object edtCepDeEntrega: TEdit
              Left = 101
              Top = 11
              Width = 84
              Height = 21
              Enabled = False
              ReadOnly = True
              TabOrder = 0
            end
          end
        end
      end
      object pnlDataFrete: TPanel
        Left = 0
        Top = 371
        Width = 906
        Height = 223
        Align = alTop
        BevelOuter = bvNone
        Caption = 'pnlDataFrete'
        TabOrder = 2
        object gpbDataFrete: TGroupBox
          Left = 0
          Top = 0
          Width = 906
          Height = 223
          Align = alTop
          Caption = 'DataFrete'
          TabOrder = 0
          object cxgDataFrete: TcxGridCitel
            Left = 2
            Top = 56
            Width = 902
            Height = 165
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxGridDBTableViewCitel1: TcxGridDBTableViewCitel
              Navigator.Buttons.CustomButtons = <>
              OnCustomDrawCell = cxGridCitel1DBTableViewCitel1CustomDrawCell
              DataController.DataSource = dtsDataFrete
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsSelection.CellSelect = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxGridDBColumn1: TcxGridDBColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'TRA_CODTRA'
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 73
              end
              object cxGridDBColumn2: TcxGridDBColumn
                Caption = 'Transportadora'
                DataBinding.FieldName = 'TRA_NOMTRA'
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 150
              end
              object cxGridDBColumn7: TcxGridDBColumn
                Caption = 'CNPJ'
                DataBinding.FieldName = 'TRA_C_G_C_'
              end
              object cxGridDBColumn5: TcxGridDBColumn
                Caption = 'Previs'#227'o de Entrega'
                DataBinding.FieldName = 'TRA_PREENT'
                Width = 105
              end
              object cxGridDBColumn3: TcxGridDBColumn
                Caption = 'Dias '#218'teis Entrega'
                DataBinding.FieldName = 'TRA_DIAENT'
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 139
              end
              object cxGridDBColumn4: TcxGridDBColumn
                Caption = 'Valor Frete'
                DataBinding.FieldName = 'TRA_VLRFRE'
                HeaderAlignmentHorz = taCenter
                Width = 114
              end
              object cxGridDBColumn6: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'TRA_DESCRI'
              end
            end
            object cxGridLevel1: TcxGridLevel
              GridView = cxGridDBTableViewCitel1
            end
          end
          object pnlSuperiorDataFrete: TPanel
            Left = 2
            Top = 15
            Width = 902
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object lblCepDataFrete: TLabel
              Left = 16
              Top = 14
              Width = 82
              Height = 13
              Caption = 'CEP de Entrega: '
            end
            object edtCepDataFrete: TEdit
              Left = 101
              Top = 11
              Width = 84
              Height = 21
              Enabled = False
              ReadOnly = True
              TabOrder = 0
            end
          end
        end
      end
      object pnlIntelipost: TPanel
        Left = 0
        Top = 594
        Width = 906
        Height = 214
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 3
        object gpbIntelipost: TGroupBox
          Left = 0
          Top = 0
          Width = 906
          Height = 214
          Align = alClient
          Caption = 'Intelipost'
          TabOrder = 0
          object cxgIntelipost: TcxGridCitel
            Left = 2
            Top = 56
            Width = 902
            Height = 156
            Align = alClient
            TabOrder = 0
            LookAndFeel.ScrollbarMode = sbmClassic
            object cxGridDBTableViewCitel2: TcxGridDBTableViewCitel
              Navigator.Buttons.CustomButtons = <>
              DataController.DataSource = dtsIntelipost
              DataController.Filter.Options = [fcoCaseInsensitive]
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              FilterRow.InfoText = 'Clique aqui para definir um filtro'
              FilterRow.ApplyChanges = fracDelayed
              OptionsSelection.CellSelect = False
              OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
              OptionsView.GroupByBox = False
              Zebra = False
              Destaque = False
              CorZebra = clMoneyGreen
              object cxGridDBColumn8: TcxGridDBColumn
                Caption = 'C'#243'digo'
                DataBinding.FieldName = 'TRA_CODTRA'
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 73
              end
              object cxGridDBColumn9: TcxGridDBColumn
                Caption = 'Transportadora'
                DataBinding.FieldName = 'TRA_NOMTRA'
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 150
              end
              object cxGridDBColumn12: TcxGridDBColumn
                Caption = 'Dias '#218'teis Entrega'
                DataBinding.FieldName = 'TRA_DIAENT'
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 139
              end
              object cxGridDBColumn13: TcxGridDBColumn
                Caption = 'Valor Frete'
                DataBinding.FieldName = 'TRA_VLRFRE'
                HeaderAlignmentHorz = taCenter
                Width = 114
              end
              object cxGridDBColumn14: TcxGridDBColumn
                Caption = 'Descri'#231#227'o'
                DataBinding.FieldName = 'TRA_DESCRI'
              end
            end
            object cxGridLevel2: TcxGridLevel
              GridView = cxGridDBTableViewCitel2
            end
          end
          object Panel1: TPanel
            Left = 2
            Top = 15
            Width = 902
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            TabOrder = 1
            object lblCepIntelipost: TLabel
              Left = 16
              Top = 14
              Width = 82
              Height = 13
              Caption = 'CEP de Entrega: '
            end
            object edtCepIntelipost: TEdit
              Left = 101
              Top = 11
              Width = 84
              Height = 21
              Enabled = False
              ReadOnly = True
              TabOrder = 0
            end
          end
        end
      end
    end
    object tsItens: TTabSheet
      Caption = 'tsItens'
      ImageIndex = 2
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object cxGridCitel2: TcxGridCitel
        Left = 0
        Top = 0
        Width = 906
        Height = 842
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object cxGridCitel2DBTableViewCitel1: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsItens
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object cxGridCitel2DBTableViewCitel1Column1: TcxGridDBColumn
            Caption = 'C'#243'digo do Item'
            DataBinding.FieldName = 'ITE_CODITE'
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 89
          end
          object cxGridCitel2DBTableViewCitel1Column2: TcxGridDBColumn
            Caption = 'Nome do Item'
            DataBinding.FieldName = 'ITE_NOMITE'
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
            Options.Editing = False
            Width = 201
          end
          object cxGridCitel2DBTableViewCitel1Column3: TcxGridDBColumn
            Caption = 'Peso'
            DataBinding.FieldName = 'ITE_PESO__'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridCitel2DBTableViewCitel1Column4: TcxGridDBColumn
            Caption = 'Largura (cm)'
            DataBinding.FieldName = 'ITE_LARGUR'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridCitel2DBTableViewCitel1Column5: TcxGridDBColumn
            Caption = 'Altura (cm)'
            DataBinding.FieldName = 'ITE_ALTURA'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
          object cxGridCitel2DBTableViewCitel1Column6: TcxGridDBColumn
            Caption = 'Profundidade (cm)'
            DataBinding.FieldName = 'ITE_PROFUN'
            HeaderAlignmentHorz = taCenter
            Width = 100
          end
        end
        object cxGridCitel2Level1: TcxGridLevel
          GridView = cxGridCitel2DBTableViewCitel1
        end
      end
    end
  end
  object pnlEndPartida: TPanel [3]
    Left = 0
    Top = 818
    Width = 914
    Height = 34
    Align = alBottom
    ParentColor = True
    TabOrder = 3
    Visible = False
    object lblEndPartida: TLabel
      Left = 17
      Top = 10
      Width = 104
      Height = 13
      Caption = 'Endere'#231'o de partida: '
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 96
    Top = 40
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 64
    Top = 40
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 32
  end
  object dtsFrenet: TDataSource
    AutoEdit = False
    Left = 23
    Top = 238
  end
  object dtsItens: TDataSource
    Left = 71
    Top = 238
  end
  object dtsDataFrete: TDataSource
    Left = 44
    Top = 497
  end
  object dtsIntelipost: TDataSource
    Left = 36
    Top = 688
  end
end
