inherited frmPreOrcamentoEdicao: TfrmPreOrcamentoEdicao
  Width = 1251
  Height = 784
  BorderStyle = bsSizeable
  Caption = 'An'#225'lise de Compras'
  WindowState = wsMaximized
  OnKeyPress = FormKeyPress
  OnKeyUp = FormKeyUp
  ExplicitTop = -65
  ExplicitWidth = 1251
  ExplicitHeight = 784
  PixelsPerInch = 96
  TextHeight = 14
  object splAplicacao: TSplitter [0]
    Left = 0
    Top = 344
    Width = 1235
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Beveled = True
    Color = clYellow
    MinSize = 20
    ParentColor = False
    ResizeStyle = rsNone
    ExplicitLeft = -120
    ExplicitTop = 338
  end
  inherited pnlBotoes: TPanel
    Top = 703
    Width = 1235
    TabOrder = 6
    ExplicitTop = 703
    ExplicitWidth = 1235
    inherited FlwBotoes: TFlowPanel
      Width = 1231
      ExplicitWidth = 1231
      inherited btnConfirma: TBitBtnLocked
        Width = 107
        Caption = '[ F10 ] Confirma'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000040000
          00130000001E0000002000000020000000200000002100000021000000210000
          002200000022000000220000002300000021000000160000000500000012281E
          16CB37291EFF463A31FFBD8150FFBC7E4DFFB97949FFB67646FFB37141FFB06D
          3DFFAD6839FFAB6535FF42362EFF3D3026FF241A13CE00000015000000193B2C
          21FF685C54FF483C34FFE8C28BFFE7C088FFE6BD85FFE5BB81FFE4B87CFFE3B5
          79FFE2B276FFE2B273FF443931FF51433AFF34261DFF0000001E000000183E2F
          24FF6C6057FF4A3F37FFD9B27DFFD8B07BFFD7AE77FFD7AB74FFD6A970FFD5A6
          6DFFD4A56AFFD4A268FF473B33FF5B4F47FF37291EFF0000001D000000164031
          26FF6F645CFF4C4038FFFFFFFFFFF7F1EBFFF7F0EBFFF7F0EBFFF7EFEBFFF6EF
          EAFFF6EFEAFFF6EFE9FF463B34FF5D5249FF3A2C21FF0000001B000000144434
          29FF73675FFF4F443CFFFFFFFFFFF8F2EDFFF8F1EDFFF7F1EDFFF7F0EDFFF8F1
          EBFFF7F0EBFFF7F0ECFF4A4037FF5F534BFF3D2E23FF00000019000000124637
          2CFF776B63FF50453DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFF4E433BFF61544CFF403126FF0000001700000010493A
          2FFF796E66FF50453DFF61564EFF60564EFF60554DFF5F544CFF5E544CFF5E53
          4BFF5D524AFF5C5249FF5B5149FF61554DFF433429FF000000150000000E4C3D
          32FF7C706AFF674E44FF654B42FF634A41FF61473FFF5F473EFF5C443CFF5B43
          3AFF594139FF584038FF573F37FF63574FFF46362DFF000000130000000D4E3F
          35FF80746DFF6B5248FFF4ECE6FFE9DACEFFE9D8CDFFE9D8CCFFE9D8CBFFE8D7
          CAFFF3EAE2FFF3E9E2FF5A4139FF645850FF483A2FFF000000110000000B5142
          36FF827770FF70564DFFF9F5F2FFF4EAE4FFF1E6DEFFEBDCD2FFE9D9CCFF4E41
          3DFF60534CFFF3EAE3FF5D453CFF655951FF4C3D32FF0000000F000000095344
          39FF857A73FF755A50FFFAF6F3FFF5EDE7FFF4EDE6FFF4ECE6FFEFE2DAFF493D
          38FF5A4D46FFF4EBE4FF60483FFF655A52FF4F3F34FF0000000D000000075545
          3AFF887D76FF795E54FFFAF6F4FFF5EEE9FFF5EDE7FFF4EDE7FFF4ECE6FF473A
          36FF483D36FFE9D9CDFF644C43FF675A52FF514137FF0000000B000000065748
          3DFF898079FF7C6157FFFAF7F4FFFAF6F4FFFAF6F4FFFAF6F3FFFAF6F3FFFAF5
          F2FFF5EEE9FFF4ECE6FF695046FF82776FFF534439FF00000009000000034235
          2EC058493DFF7F645AFF998178FF967F75FF937A72FF8E786DFF8B7269FF866E
          64FF82695FFF7D645BFF6E544AFF56453BFF3F332BC200000005000000000000
          0002000000030000000400000004000000040000000400000005000000050000
          0005000000050000000500000006000000060000000400000001}
        ModalResult = 0
        NumGlyphs = 1
        ExplicitWidth = 107
      end
      object btnEstoqueLojas: TBitBtnLocked
        Left = 107
        Top = 0
        Width = 150
        Height = 22
        Caption = '[ F11 ] Estoque das lojas'
        TabOrder = 1
        OnClick = btnEstoqueLojasClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 1128
      Top = 3
      Width = 80
      Caption = '&Sair'
      TabOrder = 5
      ExplicitLeft = 1128
      ExplicitTop = 3
      ExplicitWidth = 80
    end
    object btnTotEmp: TBitBtnLocked
      Left = 259
      Top = 2
      Width = 228
      Height = 22
      Caption = '[ F9 ] Totais por Empresa / Gerar Pedidos'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00030000000C0000001300000014000000140000001500000015000000150000
        001600000016000000150000000E000000030000000000000000000000000000
        000B19437DC32058ABFF1F56ABFF1F56ABFF1E55AAFF1C54ABFF1D54A9FF1C52
        A9FF1B52A8FF1B51A8FF133A78C60000000D0000000000000000000000000000
        000F2763B2FF74CAF6FF60C0F4FF74CAF6FF7CCCF6FF77CAF6FF72C7F5FF6FC5
        F4FF69C3F4FF65C0F3FF1D53A9FF000000120000000000000000000000000000
        000E2A69B3FB7FCBF2FF52A3DBFF306CB2FF2F6BB1FF2E6AB1FF2D69B1FF2D68
        B0FF2C67B0FF2A65B0FF1F4A82C90000000C0000000000000000000000000000
        00081738629A67A6D9FF89D6F9FF4C94CFFF0B2459BA0002052A000000140000
        001100000011000000110000000B000000030000000000000000000000000000
        00010000000B1A3C689F6CACDCFF8DD8F9FF58A8E0FF102E68C5010205180000
        0002000000000000000000000000000000000000000000000000000000000000
        0000000000020000000D1B3F68A167ABDCFF78D1F8FF59A9DFFF0D2556A80000
        0007000000000000000000000000000000000000000000000000000000000000
        0000000000010000000B091B4B9F4D8DC5FF7BD4F9FF6EB4E1FF1E4673AA0000
        0007000000000000000000000000000000000000000000000000000000000000
        0001000000090A1F4D9B5694CAFF84DBFAFF7ABEE6FF2B5A8CC2020407160000
        0002000000000000000000000000000000000000000000000000000000000000
        00050C224D94649BCBFF8FE2FCFF81C3E8FF27547FB30204071E0000000D0000
        000B0000000C0000000B00000007000000020000000000000000000000000000
        00074186C5FBA1E3F9FF67B9E4FF3777BCFF3372B7FF316EB5FF2E6AB2FF2C67
        B0FF2A63ADFF2961ACFF1B4278BF000000070000000000000000000000000000
        0007458FCBFFC7F4FEFFC4F2FEFFC3F2FEFFBFF0FEFFBCF0FEFFB9EEFDFFB5ED
        FDFFB2ECFCFFAEEBFCFF3677BBFF000000090000000000000000000000000000
        000431729AC14299D0FF4298D0FF4398CFFF4397CFFF4396CFFF4395CEFF4294
        CEFF4292CDFF4190CCFF2C6090C3000000060000000000000000000000000000
        0001000000030000000600000006000000060000000600000007000000070000
        0007000000080000000700000005000000010000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 1
      OnClick = btnTotEmpClick
    end
    object btnSatelites: TBitBtnLocked
      Left = 485
      Top = 2
      Width = 112
      Height = 22
      Caption = '[ F8 ] Sat'#233'lites'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        000000000005070402190000000C000000040000000100000000000000000000
        0001000000040000000C07040219000000050000000000000000000000000000
        00000000000C784426D5532F18A20E0804310000000D00000005000000050000
        000E0E080432532F18A2784426D50000000D0000000000000000000000000000
        00000000000E6F4024C8C39163FF9B5E35FB5B341CAD170D0742170D07425B34
        1BAD9C5E35FBC38D5BFF704123C90000000E0000000000000000000000000000
        00000000000B5D361FABC99A6EFFE3B77DFFC7925EFFA4683DFFA4693DFFC792
        5FFFE3B478FFC79565FF5D371FAC0000000C0000000000000000000000000000
        0000000000084B2D1A8FC29268FFE4B882FFE3B276FFE5B67CFFE5B77CFFE3B3
        79FFE3B379FFC18D60FF4C2D1B90000000080000000000000000000000000000
        0000000000073A231572BA875EFFE4B983FFE1AF74FFE1B175FFE2B175FFE1B1
        75FFE4B67CFFB98358FF3A231573000000070000000000000000000000000000
        00020000000D613C25A9CC9D6FFFE3B77DFFE2B276FFE2B276FFE1B277FFE2B2
        77FFE4B67EFFC89765FF5C391EAA0000000E0000000200000000000000010000
        000A4E31198FC39466FFEAC490FFEAC490FFECC794FFEDCA9AFFEDCA9AFFECC7
        95FFEBC491FFEAC391FFC39363FF4F311C910000000B0000000200000008432B
        177DC4996FFFF3D8AFFFF2D4A7FFF1D3A6FFF1D3A6FFF1D3A6FFF1D3A6FFF1D3
        A6FFF1D2A6FFF1D3A6FFF2D7ACFFC69A70FF452D1A7F000000093E291B67CAA2
        7EFFE1C3A2FFF0D9B9FFFAE8C8FFF8E4C0FFF6DCB4FFF5DAB0FFF5DAB0FFF5DA
        B0FFF6E0BAFFF9E6C6FFEFD9B7FFDFC2A0FFC79E78FF3C2717683124194C5841
        2E827B5B41B19F7656DFBE8F68FFDDBD9BFFFAE8C6FFF9E2BCFFF7E0B9FFF9E5
        C1FFDCBD9BFFBD8F69FFA17755E07B5B41B158412F833224194D000000020000
        00040000000500000007090705166B533D95E0C3A0FFFBEAC9FFFAE8C5FFE0C2
        9FFF6A533D950907051600000008000000060000000400000002000000000000
        000000000000000000000000000107050411B28C69E7F7E6C7FFF7E6C6FFB38C
        6AE8070504110000000100000000000000000000000000000000000000000000
        0000000000000000000000000000000000024A3B2C65DEBE9AFFDEBE9AFF4A3A
        2C65000000030000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000102020108AA8968D2AA8967D30202
        0108000000010000000000000000000000000000000000000000000000000000
        00000000000000000000000000000000000000000001392F2349392F23490000
        0001000000000000000000000000000000000000000000000000}
      TabOrder = 2
      OnClick = btnSatelitesClick
    end
    object btnSimilares: TBitBtnLocked
      Left = 598
      Top = 2
      Width = 112
      Height = 22
      Caption = '[ F7 ] Similares'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000002000000080000000C0000000D0000000D0000000E0000000E0000
        000E0000000E0000000F0000000F0000000E0000000900000002000000000000
        0000000000078B664BBFB57951FFB47851FFB4764FFFB2754EFFB2744DFFB273
        4CFFB1734CFFB1714AFFB07149FFAF6F48FF7E4F33C100000009000000000000
        00000000000ACBA07AFFF9EFD0FFEFD9AEFFEFD6ADFFEED5AAFFEDD4A9FFECD3
        A7FFEBD1A5FFEBD0A3FFEACEA1FFEACD9FFFB47750FF0000000D000000000000
        000000000009D0A984FFFBF4D7FFE7C593FFE6C491FFE7C390FFE5C18FFFE5C0
        8DFFE3C08CFFE5BF8BFFE3BE8AFFEDD4A8FFBA815AFF0000000D000000000000
        000000000008D3AE89FFFDF7DCFFFCF6DAFFFCF5D9FFFCF4D8FFFBF3D6FFFBF2
        D4FFFAF0D2FFF9EFCFFFF8EDCDFFF8EBCBFFBF8C66FF0000000B000000000000
        0000000000059D8267C2D3B08BFFD4AF8AFFD4AF8AFFD4AF8AFFD2AF8AFFD3AE
        89FFD3AE89FFD3AE89FFD2AD88FFD2AC87FF9B7F63C400000007000000040000
        0006000000080000000B0000000E0000000E0000000F00000010000000100000
        0010000000100000000E0000000A0000000900000006000000028B664BBBB579
        51FFB47851FFB4764FFFB2754EFFB2744DFFB2734CFFB1734CFFB1714AFFB071
        49FFAF6F48FF7D5033BC00000005000000000000000000000000CBA07AFFFBF2
        D5FFF4E3BEFFF4E1BCFFF3E0BBFFF2DFB9FFF1DEB7FFF1DCB5FFF1DBB3FFF0D9
        B1FFEFD8AFFFB47750FF00000007000000000000000000000000D0A984FFFCF6
        DAFFF1DAB1FFF0D8AFFFF0D7ADFFEED6ACFFEED4AAFFEDD4A8FFEDD2A7FFECD1
        A5FFF2DFB9FFBA815AFF00000006000000000000000000000000D3AE89FFFDF8
        DDFFFDF8DDFFFDF7DCFFFDF6DBFFFCF6DAFFFCF5D9FFFCF4D7FFFBF3D6FFFAF2
        D4FFFAF0D2FFBF8C66FF000000050000000000000000000000009D8267BFD3B0
        8BFFD4AF8AFFD4AF8AFFD4AF8AFFD2AF8AFFD3AE89FFD3AE89FFD3AE89FFD2AD
        88FFD2AC87FF9B7E63C000000003000000000000000000000000000000010000
        0002000000020000000200000002000000030000000300000003000000030000
        0003000000030000000200000001000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      TabOrder = 3
      OnClick = btnSimilaresClick
    end
    object btnPedCompGrid: TBitBtnLocked
      Left = 710
      Top = 2
      Width = 157
      Height = 22
      Caption = '[ F12 ] Pedido Compra (Grid)'
      TabOrder = 4
      OnClick = btnPedCompGridClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 729
    Width = 1235
    TabOrder = 7
    ExplicitTop = 729
    ExplicitWidth = 1235
    inherited pnlNomeForm: TPanel
      Left = 1064
      ExplicitLeft = 1064
    end
    inherited pnlInfo: TPanel
      Width = 1064
      ExplicitWidth = 1064
    end
  end
  object cxgItens: TcxGrid [3]
    Left = 0
    Top = 130
    Width = 1235
    Height = 214
    Align = alClient
    TabOrder = 5
    LookAndFeel.ScrollbarMode = sbmClassic
    object cxvItens: TcxGridDBBandedTableView
      OnKeyDown = cxvItensKeyDown
      Navigator.Buttons.CustomButtons = <>
      OnCellClick = cxvItensCellClick
      OnCustomDrawCell = cxvItensCustomDrawCell
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVALIPI
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVALSUB
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVALTOT
        end
        item
          Format = '0'
          Kind = skSum
          Column = cxvItensIND_PP
        end
        item
          Format = '0'
          Kind = skSum
          Column = cxvItensINDRUP
        end
        item
          Format = ',0'
          Kind = skCount
          Column = cxvItensCODITE
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES00
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES01
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES02
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES03
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES04
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES05
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES06
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES07
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES08
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES09
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES10
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES11
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensVMES12
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensESTDIS
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensPEDCOM
        end
        item
          Format = ',0.00;-,0.00'
          Kind = skSum
          Column = cxvItensMEDMEM
        end>
      DataController.Summary.SummaryGroups = <>
      DataController.OnCompare = cxvItensDataControllerCompare
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.Visible = True
      FilterRow.ApplyChanges = fracImmediately
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsView.NoDataToDisplayInfoText = '<Nenhum item encontrado>'
      OptionsView.Footer = True
      OptionsView.GroupByBox = False
      OnColumnHeaderClick = cxvItensColumnHeaderClick
      Bands = <
        item
          Caption = 'Produto'
          FixedKind = fkLeft
        end
        item
          Caption = 'Sugest'#227'o'
          Width = 208
        end
        item
          Caption = 'Valores do Pedido'
          Width = 650
        end
        item
          Caption = 'Dados do Giro'
          Width = 1680
        end
        item
          Caption = 'Dias Estoque'
          Width = 500
        end>
      object cxvItensDESBAN: TcxGridDBBandedColumn
        Caption = 'Bandeira'
        DataBinding.FieldName = 'PRE_DESBAN'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 54
        Position.BandIndex = 0
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensCODEMP: TcxGridDBBandedColumn
        Caption = 'Empresa'
        DataBinding.FieldName = 'PRE_SIGEMP'
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 51
        Position.BandIndex = 0
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensREFERE: TcxGridDBBandedColumn
        Caption = 'Refer'#234'ncia'
        DataBinding.FieldName = 'PRE_REFERE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        SortIndex = 0
        SortOrder = soAscending
        Width = 80
        Position.BandIndex = 0
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvItensDESITE: TcxGridDBBandedColumn
        Caption = 'Descri'#231#227'o do Produto'
        DataBinding.FieldName = 'PRE_DESITE'
        Options.Editing = False
        SortIndex = 1
        SortOrder = soAscending
        Width = 176
        Position.BandIndex = 0
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvItensSUGEST: TcxGridDBBandedColumn
        Caption = 'Sugest'#227'o'
        DataBinding.FieldName = 'PRE_NECAJU'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnGetDisplayText = cxvItensSUGESTGetDisplayText
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 76
        Position.BandIndex = 1
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensVALTOT: TcxGridDBBandedColumn
        Caption = 'Valor Total'
        DataBinding.FieldName = 'PRE_VALTOT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 78
        Position.BandIndex = 2
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvItensQTDITE: TcxGridDBBandedColumn
        Caption = 'Quantidade'
        DataBinding.FieldName = 'PRE_QTDITE'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Properties.OnValidate = cxvItensQTDITEPropertiesValidate
        OnCustomDrawCell = cxvItensQTDITECustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Styles.Header = cxStyle1
        Width = 82
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensVALUNI: TcxGridDBBandedColumn
        Caption = 'Custo NET'
        DataBinding.FieldName = 'PRE_VALUNI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 68
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensVALIPI: TcxGridDBBandedColumn
        Caption = 'Valor IPI'
        DataBinding.FieldName = 'PRE_TOTIPI'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 75
        Position.BandIndex = 2
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvItensVALSUB: TcxGridDBBandedColumn
        Caption = 'Valor Subst.'
        DataBinding.FieldName = 'PRE_TOTSUB'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 79
        Position.BandIndex = 2
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvItensPERDES: TcxGridDBBandedColumn
        Caption = '% Desc. Adic.'
        DataBinding.FieldName = 'PRE_PERDES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Properties.OnValidate = cxvItensPERDESPropertiesValidate
        OnCustomDrawCell = cxvItensPERDESCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Styles.Header = cxStyle1
        Width = 82
        Position.BandIndex = 2
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensESTDIS: TcxGridDBBandedColumn
        Caption = 'Estoq. Dispon'#237'vel'
        DataBinding.FieldName = 'PRE_ESTDIS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 96
        Position.BandIndex = 3
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensPEDCOM: TcxGridDBBandedColumn
        Caption = 'Pedido Compra'
        DataBinding.FieldName = 'PRE_PEDCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 88
        Position.BandIndex = 3
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensMEDMEM: TcxGridDBBandedColumn
        Caption = 'M'#233'dia Giro Mensal'
        DataBinding.FieldName = 'PRE_MEDMES'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.Alignment.Horz = taRightJustify
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 99
        Position.BandIndex = 3
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensVMES00: TcxGridDBBandedColumn
        Caption = 'M'#234's 0'
        DataBinding.FieldName = 'PRE_VMES00'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES00CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
        Position.BandIndex = 3
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvItensVMES01: TcxGridDBBandedColumn
        Caption = 'M'#234's 1'
        DataBinding.FieldName = 'PRE_VMES01'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES01CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 79
        Position.BandIndex = 3
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvItensVMES02: TcxGridDBBandedColumn
        Caption = 'M'#234's 2'
        DataBinding.FieldName = 'PRE_VMES02'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES01CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 78
        Position.BandIndex = 3
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvItensVMES03: TcxGridDBBandedColumn
        Caption = 'M'#234's 3'
        DataBinding.FieldName = 'PRE_VMES03'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES01CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 79
        Position.BandIndex = 3
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxvItensVMES04: TcxGridDBBandedColumn
        Caption = 'M'#234's 4'
        DataBinding.FieldName = 'PRE_VMES04'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES04CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 79
        Position.BandIndex = 3
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxvItensVMES05: TcxGridDBBandedColumn
        Caption = 'M'#234's 5'
        DataBinding.FieldName = 'PRE_VMES05'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES04CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
        Position.BandIndex = 3
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxvItensVMES06: TcxGridDBBandedColumn
        Caption = 'M'#234's 6'
        DataBinding.FieldName = 'PRE_VMES06'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES04CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 78
        Position.BandIndex = 3
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxvItensVMES07: TcxGridDBBandedColumn
        Caption = 'M'#234's 7'
        DataBinding.FieldName = 'PRE_VMES07'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES07CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
        Position.BandIndex = 3
        Position.ColIndex = 12
        Position.RowIndex = 0
      end
      object cxvItensVMES08: TcxGridDBBandedColumn
        Caption = 'M'#234's 8'
        DataBinding.FieldName = 'PRE_VMES08'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES07CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 78
        Position.BandIndex = 3
        Position.ColIndex = 13
        Position.RowIndex = 0
      end
      object cxvItensVMES09: TcxGridDBBandedColumn
        Caption = 'M'#234's 9'
        DataBinding.FieldName = 'PRE_VMES09'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES07CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 78
        Position.BandIndex = 3
        Position.ColIndex = 14
        Position.RowIndex = 0
      end
      object cxvItensVMES10: TcxGridDBBandedColumn
        Caption = 'M'#234's 10'
        DataBinding.FieldName = 'PRE_VMES10'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES07CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 81
        Position.BandIndex = 3
        Position.ColIndex = 15
        Position.RowIndex = 0
      end
      object cxvItensVMES11: TcxGridDBBandedColumn
        Caption = 'M'#234's 11'
        DataBinding.FieldName = 'PRE_VMES11'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES07CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 79
        Position.BandIndex = 3
        Position.ColIndex = 16
        Position.RowIndex = 0
      end
      object cxvItensVMES12: TcxGridDBBandedColumn
        Caption = 'M'#234's 12'
        DataBinding.FieldName = 'PRE_VMES12'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        OnCustomDrawCell = cxvItensVMES07CustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 79
        Position.BandIndex = 3
        Position.ColIndex = 17
        Position.RowIndex = 0
      end
      object cxvItensESTMIN: TcxGridDBBandedColumn
        Caption = 'Est. M'#237'nimo'
        DataBinding.FieldName = 'PRE_ESTMIN'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
        Position.BandIndex = 4
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensESTMAX: TcxGridDBBandedColumn
        Caption = 'Est.M'#225'ximo'
        DataBinding.FieldName = 'PRE_ESTMAX'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 81
        Position.BandIndex = 4
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensDIASUG: TcxGridDBBandedColumn
        Caption = 'Dias Est. Sug.'
        DataBinding.FieldName = 'PRE_DIASUG'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 76
        Position.BandIndex = 4
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvItensIND_PP: TcxGridDBBandedColumn
        Caption = 'Ind. PP'
        DataBinding.FieldName = 'PRE_INDIPP'
        OnGetDisplayText = cxvItensIND_PPGetDisplayText
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 48
        Position.BandIndex = 4
        Position.ColIndex = 5
        Position.RowIndex = 0
      end
      object cxvItensINDRUP: TcxGridDBBandedColumn
        Caption = 'Ind. Rup.'
        DataBinding.FieldName = 'PRE_COMPEN'
        OnGetDisplayText = cxvItensINDRUPGetDisplayText
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 48
        Position.BandIndex = 4
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvItensDIAGIR: TcxGridDBBandedColumn
        Caption = 'Dias Giro'
        DataBinding.FieldName = 'PRE_DIAGIR'
        OnCustomDrawCell = cxvItensDIAGIRCustomDrawCell
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 62
        Position.BandIndex = 3
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvItensMLTCOM: TcxGridDBBandedColumn
        Caption = 'M'#250'lt.Compra'
        DataBinding.FieldName = 'PRE_MLTCOM'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 70
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
      object cxvItensUSAMES: TcxGridDBBandedColumn
        DataBinding.FieldName = 'PRE_USAMES'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 6
        Position.RowIndex = 0
      end
      object cxvItensMESGIR: TcxGridDBBandedColumn
        DataBinding.FieldName = 'PRE_MESGIR'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
      object cxvItensNIVGIR: TcxGridDBBandedColumn
        Caption = 'Curva ABC'
        DataBinding.FieldName = 'PRE_NIVGIR'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 62
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensCODITE: TcxGridDBBandedColumn
        Caption = 'C'#243'd.Prod.'
        DataBinding.FieldName = 'PRE_CODITE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 61
        Position.BandIndex = 0
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensUNILIQ: TcxGridDBBandedColumn
        Caption = 'Vr. Unit'#225'rio L'#237'q.'
        DataBinding.FieldName = 'PRE_UNILIQ'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Properties.OnValidate = cxvItensUNILIQPropertiesValidate
        OnCustomDrawCell = cxvItensUNILIQCustomDrawCell
        HeaderAlignmentHorz = taRightJustify
        Styles.Content = cxStyle1
        Styles.Header = cxStyle1
        Width = 91
        Position.BandIndex = 2
        Position.ColIndex = 4
        Position.RowIndex = 0
      end
      object cxvItensDIAEST: TcxGridDBBandedColumn
        Caption = 'Dias Estoque'
        DataBinding.FieldName = 'PRE_DIAEST'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 73
        Position.BandIndex = 4
        Position.ColIndex = 3
        Position.RowIndex = 0
      end
      object cxvItensANTIGO: TcxGridDBBandedColumn
        Caption = 'Pedido Mais Antigo'
        DataBinding.FieldName = 'PRE_ANTIGO'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 100
        Position.BandIndex = 3
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensCORBAN: TcxGridDBBandedColumn
        DataBinding.FieldName = 'BAN_CORBAN'
        Visible = False
        Position.BandIndex = 0
        Position.ColIndex = 8
        Position.RowIndex = 0
      end
      object cxvItensDESMAR: TcxGridDBBandedColumn
        Caption = 'Marca'
        DataBinding.FieldName = 'MAR_DESMAR'
        Options.Editing = False
        Width = 125
        Position.BandIndex = 0
        Position.ColIndex = 9
        Position.RowIndex = 0
      end
      object cxvItensDTAULT: TcxGridDBBandedColumn
        Caption = #218'ltima Compra'
        DataBinding.FieldName = 'ITE_DTAULT'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 80
        Position.BandIndex = 3
        Position.ColIndex = 18
        Position.RowIndex = 0
      end
      object cxvItensDTAUVE: TcxGridDBBandedColumn
        Caption = #218'ltima Venda'
        DataBinding.FieldName = 'ITE_DTAUVE'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 75
        Position.BandIndex = 3
        Position.ColIndex = 20
        Position.RowIndex = 0
      end
      object cxvItensPRECUS: TcxGridDBBandedColumn
        Caption = 'Custo c/ impostos'
        DataBinding.FieldName = 'ITE_PRECUS'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        Options.Editing = False
        Width = 95
        Position.BandIndex = 2
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensColumn1: TcxGridDBBandedColumn
        Caption = 'Ult. Compra + Imp.'
        DataBinding.FieldName = 'ITE_IMPULT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 97
        Position.BandIndex = 0
        Position.ColIndex = 11
        Position.RowIndex = 0
      end
      object cxvItensColumn2: TcxGridDBBandedColumn
        Caption = 'Ult. Compra'
        DataBinding.FieldName = 'ITE_PREULT'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = '0.00'
        HeaderAlignmentHorz = taCenter
        Options.Editing = False
        Width = 70
        Position.BandIndex = 0
        Position.ColIndex = 10
        Position.RowIndex = 0
      end
      object cxvItensMARDES: TcxGridDBBandedColumn
        Caption = 'Sel'
        DataBinding.FieldName = 'MARDES'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        Properties.ValueChecked = '1'
        Properties.ValueUnchecked = '0'
        Width = 23
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object cxvItensDESTRE: TcxGridDBBandedColumn
        Caption = 'Dias Estoque Real'
        DataBinding.FieldName = 'PRE_DESTRE'
        Width = 94
        Position.BandIndex = 4
        Position.ColIndex = 2
        Position.RowIndex = 0
      end
      object cxvItensColumn3: TcxGridDBBandedColumn
        Caption = 'Qtd.'#218'lt.Compra'
        DataBinding.FieldName = 'ITE_QTDUCO'
        PropertiesClassName = 'TcxCurrencyEditProperties'
        Properties.DisplayFormat = ',0.00;-,0.00'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Width = 80
        Position.BandIndex = 3
        Position.ColIndex = 19
        Position.RowIndex = 0
      end
      object cxvItensESTEXCESSO: TcxGridDBBandedColumn
        Caption = 'Est. Excesso'
        DataBinding.FieldName = 'ESTEXCESSO'
        HeaderAlignmentHorz = taRightJustify
        Options.Editing = False
        Position.BandIndex = 4
        Position.ColIndex = 7
        Position.RowIndex = 0
      end
    end
    object cxgItensLevel1: TcxGridLevel
      GridView = cxvItens
    end
  end
  object pnlFornecedor: TPanel [4]
    Left = 0
    Top = 0
    Width = 1235
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 19
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
    object lblHub: TLabel
      Left = 694
      Top = 19
      Width = 24
      Height = 14
      Alignment = taRightJustify
      Caption = 'HUB:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 81
      Top = 15
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 145
      Top = 15
      Width = 543
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
    object edtHub: TEditFocus
      Tag = 99
      Left = 720
      Top = 15
      Width = 63
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ReadOnly = True
      TabOrder = 2
      Visible = False
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
  end
  object pnlAplicacao: TPanel [5]
    Left = 0
    Top = 347
    Width = 1235
    Height = 356
    Align = alBottom
    BevelOuter = bvNone
    ParentBackground = False
    ParentColor = True
    TabOrder = 4
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 1235
      Height = 21
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object btnDesmarcaTodos: TBitBtnLocked
        Left = 282
        Top = 0
        Width = 161
        Height = 22
        Caption = '[ F6 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          333333333333333333FF33333333333330003333333333333777333333333333
          300033FFFFFF3333377739999993333333333777777F3333333F399999933333
          3300377777733333337733333333333333003333333333333377333333333333
          3333333333333333333F333333333333330033333F33333333773333C3333333
          330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
          333333377F33333333FF3333C333333330003333733333333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnDesmarcaTodosClick
      end
      object btnMarcaTodos: TBitBtnLocked
        Left = 166
        Top = 0
        Width = 116
        Height = 22
        Caption = '[ F5 ] Marca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333FF33333333FF333993333333300033377F3333333777333993333333
          300033F77FFF3333377739999993333333333777777F3333333F399999933333
          33003777777333333377333993333333330033377F3333333377333993333333
          3333333773333333333F333333333333330033333333F33333773333333C3333
          330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
          333333333337733333FF3333333C333330003333333733333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnMarcaTodosClick
      end
      object btnmarcaDesmarca: TBitBtnLocked
        Left = 1
        Top = 0
        Width = 164
        Height = 22
        Caption = '[ Espaco ] Marca/Desmarca'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333333FF33333333FF333993333333300033377F3333333777333993333333
          300033F77FFF3333377739999993333333333777777F3333333F399999933333
          33003777777333333377333993333333330033377F3333333377333993333333
          3333333773333333333F333333333333330033333333F33333773333333C3333
          330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
          993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
          333333333337733333FF3333333C333330003333333733333777333333333333
          3000333333333333377733333333333333333333333333333333}
        NumGlyphs = 2
        TabOrder = 0
        OnClick = btnmarcaDesmarcaClick
      end
    end
    object Panel4: TPanel
      Left = 0
      Top = 21
      Width = 1235
      Height = 98
      Align = alTop
      TabOrder = 1
      object lblResPad: TLabel
        Left = 582
        Top = 37
        Width = 132
        Height = 14
        Cursor = crHandPoint
        Caption = 'Restaura padr'#227'o do grid'
        Color = clWhite
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = [fsBold, fsUnderline]
        ParentColor = False
        ParentFont = False
        OnClick = lblResPadClick
      end
      object Label3: TLabel
        Left = 598
        Top = 57
        Width = 184
        Height = 28
        Caption = 
          'Os valores em cinza n'#227'o entraram no c'#225'lculo da m'#233'dia mensal de g' +
          'iro'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Shape1: TShape
        Left = 582
        Top = 57
        Width = 14
        Height = 14
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Brush.Color = clMedGray
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
      end
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 573
        Height = 96
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'Panel1'
        TabOrder = 0
        object pnlTitAplic: TPanel
          Left = 0
          Top = 0
          Width = 573
          Height = 18
          Align = alTop
          BevelOuter = bvNone
          Caption = 'Aplica'#231#227'o'
          Color = 16770261
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
        end
        object dbeAplica: TDBMemoFocus
          Left = 0
          Top = 18
          Width = 573
          Height = 56
          Align = alClient
          DataField = 'PRE_APLICA'
          ReadOnly = True
          TabOrder = 1
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          StringQuebra = '<<csq>>'
        end
        object Panel5: TPanel
          Left = 0
          Top = 74
          Width = 573
          Height = 22
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
          object Label10: TLabel
            Left = 8
            Top = 4
            Width = 78
            Height = 14
            Caption = 'Giro do produto:'
          end
          object edtProdutoDoRodape: TEditFocus
            Left = 88
            Top = 1
            Width = 485
            Height = 22
            TabStop = False
            Alignment = taLeftJustify
            ReadOnly = True
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
      object GroupBox1: TGroupBox
        Left = 788
        Top = 0
        Width = 429
        Height = 94
        Caption = 'Op'#231#245'es de Visualiza'#231#227'o'
        TabOrder = 1
        object Label4: TLabel
          Left = 12
          Top = 16
          Width = 82
          Height = 14
          Caption = 'Agrupador.......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 12
          Top = 32
          Width = 83
          Height = 14
          Caption = 'Comprador......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 12
          Top = 46
          Width = 84
          Height = 14
          Caption = 'Marca................:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 12
          Top = 61
          Width = 84
          Height = 14
          Caption = 'Fornecedor......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 12
          Top = 76
          Width = 84
          Height = 14
          Caption = 'Departamento.:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblAgrupador: TLabel
          Left = 100
          Top = 16
          Width = 75
          Height = 14
          Caption = 'Agrupador.......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblComprador: TLabel
          Left = 100
          Top = 32
          Width = 75
          Height = 14
          Caption = 'Agrupador.......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblMarca: TLabel
          Left = 101
          Top = 46
          Width = 75
          Height = 14
          Caption = 'Agrupador.......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblFornecedor: TLabel
          Left = 100
          Top = 61
          Width = 75
          Height = 14
          Caption = 'Agrupador.......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDepartemento: TLabel
          Left = 100
          Top = 76
          Width = 75
          Height = 14
          Caption = 'Agrupador.......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblDescSobEnc: TLabel
          Left = 185
          Top = 16
          Width = 156
          Height = 14
          Caption = 'Produtos sob encomenda.?:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblValDescSobEnc: TLabel
          Left = 347
          Top = 15
          Width = 75
          Height = 14
          Caption = 'Agrupador.......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblLinGru: TLabel
          Left = 185
          Top = 32
          Width = 157
          Height = 14
          Caption = 'Linha/Grupo.............................:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblValLinGru: TLabel
          Left = 347
          Top = 32
          Width = 75
          Height = 14
          Caption = 'Agrupador.......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
        object lblFilEmp: TLabel
          Left = 185
          Top = 46
          Width = 158
          Height = 14
          Caption = 'Empresas.................................:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lblValFilEmp: TLabel
          Left = 346
          Top = 46
          Width = 75
          Height = 14
          Caption = 'Agrupador.......:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 121
      Width = 1235
      Height = 235
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object ScrollBox1: TScrollBox
        Left = 0
        Top = -4
        Width = 1235
        Height = 239
        HorzScrollBar.Position = 614
        VertScrollBar.Visible = False
        Align = alBottom
        BorderStyle = bsNone
        ParentBackground = True
        TabOrder = 0
        object pnlContainer: TPanel
          Left = -614
          Top = 0
          Width = 1849
          Height = 222
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object Splitter1: TSplitter
            Left = 1295
            Top = 0
            Height = 222
            ExplicitLeft = 1222
            ExplicitTop = 6
          end
          object pnlPanelGiro: TPanel
            Left = 0
            Top = 0
            Width = 1295
            Height = 222
            Align = alLeft
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
          end
          object pnlContAling: TPanel
            Left = 1298
            Top = 0
            Width = 551
            Height = 222
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 1
            ExplicitLeft = 1216
            ExplicitWidth = 633
            object pnlContainerResumidos: TPanel
              Left = 0
              Top = 0
              Width = 360
              Height = 222
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object Panel7: TPanel
                Left = 0
                Top = 119
                Width = 360
                Height = 103
                Align = alClient
                BevelOuter = bvNone
                Caption = 'Panel1'
                TabOrder = 0
                object cxVerticalGrid3: TcxVerticalGrid
                  Left = 0
                  Top = 0
                  Width = 180
                  Height = 103
                  Align = alLeft
                  OptionsView.RowHeaderWidth = 96
                  OptionsData.Editing = False
                  TabOrder = 0
                  Version = 1
                  object cxCategoryRow2: TcxCategoryRow
                    Properties.Caption = '% Curva ABC do Pedido'
                    Properties.HeaderAlignmentHorz = taCenter
                    Styles.Header = cxStyle2
                    ID = 0
                    ParentID = -1
                    Index = 0
                    Version = 1
                  end
                  object cxVerCurvA: TcxEditorRow
                    Properties.Caption = 'A'
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 1
                    ParentID = -1
                    Index = 1
                    Version = 1
                  end
                  object cxVerCurvB: TcxEditorRow
                    Properties.Caption = 'B'
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 2
                    ParentID = -1
                    Index = 2
                    Version = 1
                  end
                  object cxVerCurvC: TcxEditorRow
                    Properties.Caption = 'C'
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 3
                    ParentID = -1
                    Index = 3
                    Version = 1
                  end
                end
                object cxVerticalGrid2: TcxVerticalGrid
                  Left = 180
                  Top = 0
                  Width = 180
                  Height = 103
                  Align = alLeft
                  OptionsView.RowHeaderWidth = 96
                  OptionsData.Editing = False
                  TabOrder = 1
                  Version = 1
                  object cxCategoryRow1: TcxCategoryRow
                    Properties.Caption = '% Criticidade XYZ do Pedido'
                    Properties.HeaderAlignmentHorz = taCenter
                    Styles.Header = cxStyle2
                    ID = 0
                    ParentID = -1
                    Index = 0
                    Version = 1
                  end
                  object cxVerCurvX: TcxEditorRow
                    Properties.Caption = 'X'
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 1
                    ParentID = -1
                    Index = 1
                    Version = 1
                  end
                  object cxVerCurvY: TcxEditorRow
                    Properties.Caption = 'Y'
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 2
                    ParentID = -1
                    Index = 2
                    Version = 1
                  end
                  object cxVerCurvZ: TcxEditorRow
                    Properties.Caption = 'Z'
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 3
                    ParentID = -1
                    Index = 3
                    Version = 1
                  end
                end
              end
              object Panel9: TPanel
                Left = 0
                Top = 0
                Width = 360
                Height = 119
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 1
                object cxVerticalGrid1: TcxVerticalGrid
                  Left = 0
                  Top = 0
                  Width = 360
                  Height = 119
                  Align = alClient
                  OptionsView.RowHeaderWidth = 177
                  TabOrder = 0
                  Version = 1
                  object cxVerticalGrid1CategoryRow1: TcxCategoryRow
                    Properties.Caption = 'Resumo do Pedido'
                    Properties.HeaderAlignmentHorz = taCenter
                    Styles.Header = cxStyle2
                    ID = 0
                    ParentID = -1
                    Index = 0
                    Version = 1
                  end
                  object cxVerTotPed: TcxEditorRow
                    Properties.Caption = 'Valor Total do Pedido'
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Options.Editing = False
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 1
                    ParentID = -1
                    Index = 1
                    Version = 1
                  end
                  object cxVerQtdTotPed: TcxEditorRow
                    Properties.Caption = 'Qtde. Total Do Pedido'
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Options.Editing = False
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 2
                    ParentID = -1
                    Index = 2
                    Version = 1
                  end
                  object cxVerPesTotPed: TcxEditorRow
                    Properties.Caption = 'Peso Total do Pedido(Kg)'
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Options.Editing = False
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 3
                    ParentID = -1
                    Index = 3
                    Version = 1
                  end
                  object cxVerLitTotPed: TcxEditorRow
                    Properties.Caption = 'Litros Total do Pedido(LT)'
                    Properties.EditPropertiesClassName = 'TcxButtonEditProperties'
                    Properties.EditProperties.Alignment.Horz = taLeftJustify
                    Properties.EditProperties.Buttons = <
                      item
                        Default = True
                        Kind = bkEllipsis
                      end>
                    Properties.EditProperties.ReadOnly = True
                    Properties.EditProperties.OnButtonClick = cxVerLitTotPedEditPropertiesButtonClick
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Options.Filtering = False
                    Properties.Options.ShowEditButtons = eisbAlways
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 4
                    ParentID = -1
                    Index = 4
                    Version = 1
                  end
                  object cxVerMetTotPed: TcxEditorRow
                    Properties.Caption = 'Metragem Total do Pedido(MT)'
                    Properties.DataBinding.ValueType = 'String'
                    Properties.Options.Editing = False
                    Properties.Value = Null
                    Styles.Header = cxStyle2
                    ID = 5
                    ParentID = -1
                    Index = 5
                    Version = 1
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  object pnlProduto: TPanel [6]
    Left = 0
    Top = 81
    Width = 1235
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 2
    Visible = False
    object Label2: TLabel
      Left = 27
      Top = 13
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'Produto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object edtDesIte: TEditFocus
      Left = 69
      Top = 9
      Width = 607
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlCndPag: TPanel [7]
    Left = 0
    Top = 41
    Width = 1235
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    object Label21: TLabel
      Left = 566
      Top = 12
      Width = 76
      Height = 14
      Alignment = taRightJustify
      Caption = 'Desconto Adic.:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label22: TLabel
      Left = 692
      Top = 12
      Width = 13
      Height = 14
      Caption = '% '
    end
    object Label5: TLabel
      Left = 139
      Top = 12
      Width = 46
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cnd.Pgto:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object chkPgAVis: TCheckBox
      Left = 20
      Top = 12
      Width = 113
      Height = 14
      Caption = 'Cnd. Pagto '#192' Vista'
      TabOrder = 0
      OnClick = chkPgAVisClick
    end
    object dbeDesAdi: TDBEditFocus
      Tag = 99
      Left = 645
      Top = 6
      Width = 46
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRE_DESADI'
      DataSource = dtsGPREOR
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 2
      OnEnter = dbeDesAdiEnter
      OnExit = dbeDesAdiExit
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeConPag: TDBEditFocus
      Tag = 99
      Left = 188
      Top = 6
      Width = 366
      Height = 22
      CharCase = ecUpperCase
      DataField = 'PRE_CONPAG'
      DataSource = dtsGPREOR
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
  object Panel3: TPanel [8]
    Left = 0
    Top = 114
    Width = 1235
    Height = 16
    Align = alTop
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 3
    object chkSuspOrdem: TCheckBox
      Left = 2
      Top = 0
      Width = 137
      Height = 17
      Caption = 'Suspender ordena'#231#227'o.'
      TabOrder = 0
      OnClick = chkSuspOrdemClick
    end
    object chkNextLine: TCheckBox
      Left = 506
      Top = 0
      Width = 287
      Height = 17
      Caption = 'Ao Pressionar Enter ir Sempre para linha inferior.'
      TabOrder = 2
      OnClick = chkSuspOrdemClick
    end
    object chkFiSemNecCom: TCheckBox
      Left = 165
      Top = 0
      Width = 301
      Height = 17
      Caption = 'Exibir tamb'#233'm os produtos sem necessidade de compra.'
      TabOrder = 1
      OnClick = chkFiSemNecComClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 200
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 280
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 312
    Top = 224
  end
  object dtsGPREOR: TDataSource
    Left = 816
    Top = 73
  end
  object cxStyleRepository1: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle1: TcxStyle
      AssignedValues = [svFont]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
    end
  end
  object tmrAtualizaRodape: TTimer
    Enabled = False
    Interval = 10
    OnTimer = tmrAtualizaRodapeTimer
    Left = 288
    Top = 544
  end
  object cxStyleRepository2: TcxStyleRepository
    PixelsPerInch = 96
    object cxStyle2: TcxStyle
      AssignedValues = [svColor]
      Color = 42495
    end
  end
end
