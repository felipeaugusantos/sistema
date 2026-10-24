inherited frmEditorLayoutNFSe: TfrmEditorLayoutNFSe
  Width = 800
  Height = 600
  BorderStyle = bsSizeable
  Caption = 'Editor: Layout de Importa'#231#227'o do NFSe'
  OnDestroy = FormDestroy
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 519
    Width = 784
    ExplicitTop = 519
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Width = 780
      ExplicitWidth = 780
      object btnCadastrarCampos: TBitBtnLocked
        Left = 75
        Top = 0
        Width = 165
        Height = 22
        Caption = '[ F5 ] Cadastro de Campos'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000030000000F000000180000001B0000
          001D0000001F0000002100000022000000220000001700000006000000000000
          00000000000000000000000000000000000B7B613FC5A98356FFA78153FFA67E
          51FFA37C4FFFA1794CFF9F784AFF9E7547FF6F5232CF00000017000000000000
          00000000000000000000008B0FFF00280357AE895CFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9E7648FF00000020000000000000
          000000A713FF009D12FF00920FFF008A0EFFB08C5FFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA17A4CFF0000001F000000000000
          000000AF17FF00000000009B13FF002C0555B38F62FFFFFFFFFFDDB28EFFDAAE
          89FFD7A984FFD5A57FFFD1A17AFFFFFFFFFFA47D50FF0000001C000000080000
          001000B919FF000000170000001900000024A08059FFDFDFDFFFE8E8E8FFF9F9
          F9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA78153FF000000183C6D8BBE5094
          C0FF4D92BEFF498FBCFF468BBAFF4388B7FF3F85B4FF3C82B3FF5A8DB0FFE1D5
          CBFFDDB28FFFDAAD89FFD7A984FFFFFFFFFFA98456FF000000155599C4FFBCE8
          FFFF83D4FFFF7DD3FFFF78D0FFFF71CEFFFF6BCAFFFF67C7FFFF3D82B2FFE1E1
          E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAC875AFF00000012569AC4FFCEEF
          FFFFC3EBFFFFB7E7FFFFACE2FFFFA0DDFFFF94D8FFFF89D4FFFF4086B6FFDDD2
          C9FFE2BA98FFDFB693FFDDB18EFFFFFFFFFFAF8A5DFF0000000F407291C0569A
          C4FF5699C4FF5498C3FF5296C1FF4F94BFFF4B91BDFF488DBBFF679ABCFFEFEF
          EFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB28D61FF0000000D000000020000
          00040000000500000006000000080000000CB5956AFFF1F1F1FFF3F3F3FFFCFC
          FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB49164FF0000000B000000000000
          0000000000000000000000000000000000008E7454BEBF9D71FFBE9C70FFBD9B
          6FFFBC996EFFBB986CFFBA976AFFB89568FF876D4CC200000006000000000000
          0000000000000000000000000000000000000000000000000001000000020000
          0002000000030000000400000005000000050000000400000001000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
        TabOrder = 1
        OnClick = btnCadastrarCamposClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 701
      ExplicitLeft = 701
    end
  end
  inherited pnlStatus: TPanel
    Top = 545
    Width = 784
    ExplicitTop = 545
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 577
      Width = 207
      ExplicitLeft = 577
      ExplicitWidth = 207
    end
    inherited pnlInfo: TPanel
      Width = 577
      ExplicitWidth = 577
    end
  end
  object edtNomLayout: TEdit [2]
    Tag = 99
    Left = 2
    Top = 19
    Width = 606
    Height = 22
    CharCase = ecUpperCase
    TabOrder = 2
  end
  object pnlHintCodigo: TPanel [3]
    Left = 0
    Top = 493
    Width = 784
    Height = 26
    Align = alBottom
    TabOrder = 3
    object Label3: TLabel
      Left = 1
      Top = 6
      Width = 354
      Height = 14
      Caption = 
        'Relacione os campos do xml com os campos dispon'#237'veis para import' +
        'a'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  object trlXML: TcxTreeList [4]
    Left = 0
    Top = 26
    Width = 784
    Height = 467
    Align = alClient
    Bands = <
      item
      end>
    Navigator.Buttons.CustomButtons = <>
    OptionsData.Deleting = False
    OptionsView.ColumnAutoWidth = True
    TabOrder = 4
    object colCampoCompleto: TcxTreeListColumn
      Visible = False
      DataBinding.ValueType = 'String'
      Width = 100
      Position.ColIndex = 2
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object colXML: TcxTreeListColumn
      PropertiesClassName = 'TcxLabelProperties'
      Caption.Text = 'Campos do XML'
      DataBinding.ValueType = 'String'
      Width = 211
      Position.ColIndex = 0
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object colCampo: TcxTreeListColumn
      PropertiesClassName = 'TcxLookupComboBoxProperties'
      Properties.ClearKey = 46
      Properties.KeyFieldNames = 'LAY_DESCAM'
      Properties.ListColumns = <
        item
          FieldName = 'LAY_DESCOM'
        end>
      Properties.ListOptions.ShowHeader = False
      Properties.ListSource = dsCamposCadFis
      Properties.ValidationOptions = [evoShowErrorIcon]
      Properties.OnValidate = colCampoPropertiesValidate
      Caption.Text = 'Campos da Cad. Fiscal'
      DataBinding.ValueType = 'String'
      Width = 223
      Position.ColIndex = 1
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object colFormato: TcxTreeListColumn
      PropertiesClassName = 'TcxTextEditProperties'
      Properties.CharCase = ecUpperCase
      Properties.LookupItems.Strings = (
        'DD/MM/YYYY'
        'DD/MM/YYYY HH:NN:SS'
        'YYYY/MM/DD'
        'YYYY-MM-DD'
        'YYYY-MM-DD HH:NN:SS'
        'YYYY-MM-DDTHH:NN:SS')
      Caption.Text = 'Formato'
      DataBinding.ValueType = 'String'
      Width = 100
      Position.ColIndex = 3
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
    object colTipo: TcxTreeListColumn
      Visible = False
      DataBinding.ValueType = 'String'
      Width = 100
      Position.ColIndex = 4
      Position.RowIndex = 0
      Position.BandIndex = 0
      Summary.FooterSummaryItems = <>
      Summary.GroupFooterSummaryItems = <>
    end
  end
  object pnlTop: TPanel [5]
    Left = 0
    Top = 0
    Width = 784
    Height = 26
    Align = alTop
    TabOrder = 5
    object lblTitulo: TLabel
      Left = 1
      Top = 6
      Width = 354
      Height = 14
      Caption = 
        'Relacione os campos do xml com os campos dispon'#237'veis para import' +
        'a'#231#227'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 116
    Top = 308
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 340
    Top = 152
  end
  object fsScript1: TfsScript
    SyntaxType = 'PascalScript'
    Left = 140
    Top = 204
  end
  object dsCamposCadFis: TDataSource
    Left = 384
    Top = 288
  end
end
