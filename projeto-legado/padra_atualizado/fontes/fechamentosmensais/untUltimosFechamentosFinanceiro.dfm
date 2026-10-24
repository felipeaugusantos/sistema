inherited frmUltimosFechamentosFinanceiro: TfrmUltimosFechamentosFinanceiro
  Left = 0
  Top = 0
  Width = 1052
  Height = 601
  Caption = 'Fechamento Financeiro'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  OldCreateOrder = False
  ExplicitWidth = 1052
  ExplicitHeight = 601
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlBotoes: TPanel
    Top = 530
    Width = 1046
    ExplicitTop = 530
    ExplicitWidth = 1046
    inherited FlwBotoes: TFlowPanel
      Width = 1042
      TabOrder = 3
      ExplicitTop = 2
      ExplicitWidth = 1042
    end
    inherited btnSair: TBitBtnLocked
      Left = 963
      Caption = '&Sair'
      TabOrder = 2
      ExplicitLeft = 963
    end
    object btnRevFec: TBitBtnLocked
      Left = 194
      Top = 1
      Width = 194
      Height = 22
      Caption = '[ F3 ] Excluir fechamento'
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
      TabOrder = 1
      OnClick = btnRevFecClick
    end
    object btnIncFec: TBitBtnLocked
      Left = 3
      Top = 1
      Width = 186
      Height = 22
      Caption = '[ F2 ] Incluir novo fechamento'
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
      OnClick = btnIncFecClick
    end
    object pnlInfoContabil: TPanel
      Left = 598
      Top = 5
      Width = 347
      Height = 17
      Caption = 'Fechamento Financeiro Efetuado pelo Fechamento Cont'#225'bil'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 4
    end
  end
  inherited pnlStatus: TPanel
    Top = 556
    Width = 1046
    ExplicitTop = 556
    ExplicitWidth = 1046
    inherited pnlNomeForm: TPanel
      Left = 875
      ExplicitLeft = 875
    end
    inherited pnlInfo: TPanel
      Width = 875
      ExplicitWidth = 875
    end
  end
  object pnlTopo: TPanel [3]
    Left = 0
    Top = 0
    Width = 1046
    Height = 530
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
    object Splitter1: TSplitter
      Left = 489
      Top = 0
      Width = 4
      Height = 530
      Color = clYellow
      ParentColor = False
      ExplicitLeft = 529
      ExplicitHeight = 161
    end
    object cxgEmpresas: TcxGrid
      Left = 0
      Top = 0
      Width = 489
      Height = 530
      Align = alLeft
      TabOrder = 0
      object cxvEmpresas: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.HideFocusRectOnExit = False
        OptionsView.NoDataToDisplayInfoText = '<Nenhum fechamento encontrado>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Bands = <
          item
            Caption = #218'ltimo fechamento de todas as empresas'
          end>
        object cxvEmpresasCODEMP: TcxGridDBBandedColumn
          Caption = 'Empresa'
          DataBinding.FieldName = 'FEC_CODEMP'
          HeaderAlignmentHorz = taCenter
          SortIndex = 0
          SortOrder = soDescending
          Width = 65
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxvEmpresasNOMEMP: TcxGridDBBandedColumn
          Caption = 'Nome da Empresa'
          DataBinding.FieldName = 'NOMEMP'
          Width = 302
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxvEmpresasULTFEC: TcxGridDBBandedColumn
          Caption = #218'ltimo Fechamento'
          DataBinding.FieldName = 'FEC_DTAREF'
          HeaderAlignmentHorz = taCenter
          Width = 120
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
      end
      object cxgEmpresasLevel1: TcxGridLevel
        GridView = cxvEmpresas
      end
    end
    object cxgFechamentos: TcxGrid
      Left = 493
      Top = 0
      Width = 553
      Height = 530
      Align = alClient
      TabOrder = 1
      object cxvFechamentos: TcxGridDBBandedTableView
        Navigator.Buttons.CustomButtons = <>
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para definir um filtro'
        FilterRow.Visible = True
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.CancelOnExit = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsSelection.CellSelect = False
        OptionsSelection.MultiSelect = True
        OptionsSelection.CheckBoxVisibility = [cbvDataRow, cbvColumnHeader]
        OptionsSelection.HideFocusRectOnExit = False
        OptionsSelection.InvertSelect = False
        OptionsSelection.UnselectFocusedRecordOnExit = False
        OptionsView.NoDataToDisplayInfoText = '<Nenhum fechamento encontrado>'
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        Styles.OnGetContentStyle = cxvFechamentosStylesGetContentStyle
        Bands = <
          item
            Caption = 'Fechamentos da empresa:'
          end>
        object cxvFechamentosANOMES: TcxGridDBBandedColumn
          Caption = 'Data Fechamento'
          DataBinding.FieldName = 'FEC_DTAREF'
          HeaderAlignmentHorz = taCenter
          SortIndex = 0
          SortOrder = soDescending
          Width = 111
          Position.BandIndex = 0
          Position.ColIndex = 0
          Position.RowIndex = 0
        end
        object cxvFechamentosNOMOPE: TcxGridDBBandedColumn
          Caption = 'Nome do Operador'
          DataBinding.FieldName = 'NOMOPE'
          Width = 190
          Position.BandIndex = 0
          Position.ColIndex = 2
          Position.RowIndex = 0
        end
        object cxvFechamentosDTAFEC: TcxGridDBBandedColumn
          Caption = 'Data Oper.'
          DataBinding.FieldName = 'FEC_DTAFEC'
          HeaderAlignmentHorz = taCenter
          Width = 79
          Position.BandIndex = 0
          Position.ColIndex = 3
          Position.RowIndex = 0
        end
        object cxvFechamentosCODOPE: TcxGridDBBandedColumn
          Caption = 'Operador'
          DataBinding.FieldName = 'FEC_CODOPE'
          FooterAlignmentHorz = taCenter
          HeaderAlignmentHorz = taCenter
          Width = 59
          Position.BandIndex = 0
          Position.ColIndex = 1
          Position.RowIndex = 0
        end
        object cxvFechamentosHORFEC: TcxGridDBBandedColumn
          Caption = 'Hora Oper.'
          DataBinding.FieldName = 'FEC_HORFEC'
          HeaderAlignmentHorz = taCenter
          Width = 74
          Position.BandIndex = 0
          Position.ColIndex = 4
          Position.RowIndex = 0
        end
        object cxvFechamentosFECCNT: TcxGridDBBandedColumn
          DataBinding.FieldName = 'FECCNT'
          Visible = False
          VisibleForCustomization = False
          VisibleForEditForm = bFalse
          Position.BandIndex = 0
          Position.ColIndex = 5
          Position.RowIndex = 0
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxvFechamentos
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 544
    Top = 408
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 544
    Top = 464
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 504
    Top = 464
  end
  object UniDataSource1: TUniDataSource
    Left = 596
    Top = 212
  end
  object StyleRepository: TcxStyleRepository
    Left = 690
    Top = 217
    PixelsPerInch = 96
    object estiloFecCnt: TcxStyle
      AssignedValues = [svTextColor]
      TextColor = clRed
    end
    object estiloPadrao: TcxStyle
    end
  end
end
