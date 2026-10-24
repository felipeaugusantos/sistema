inherited frmImpFranquiaDetalhe: TfrmImpFranquiaDetalhe
  Width = 800
  Height = 600
  BorderIcons = [biSystemMenu]
  Caption = 'Importa'#231#227'o de Novos Produtos Franqueadora'
  Font.Height = -11
  Position = poMainFormCenter
  OnClose = FormClose
  ExplicitWidth = 800
  ExplicitHeight = 600
  PixelsPerInch = 96
  TextHeight = 14
  object lblObs: TLabel [0]
    Left = 0
    Top = 486
    Width = 794
    Height = 42
    Align = alBottom
    Caption = 
      '   *  CASO N'#195'O SEJA INFORMADO O CODIGO J'#193' CADASTRADO PARA O REGI' +
      'STRO, SER'#193' REALIZADA A INCLUS'#195'O DE UM NOVO CADASTRO COM OS '#13#10'   ' +
      ' DADOS DO REGISTRO.'#13#10'   ** USE DELETE PARA LIMPAR UM RELACIONAME' +
      'NTO REALIZADO EM UM REGISTRO.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 773
  end
  inherited pnlBotoes: TPanel
    Top = 528
    Width = 794
    ExplicitTop = 528
    ExplicitWidth = 794
    inherited btnSair: TBitBtnLocked
      Left = 711
      ExplicitLeft = 711
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 3
      Width = 200
      Height = 22
      Caption = '[ F10 ] Confirmar Relacionamento'
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
      TabOrder = 1
      OnClick = btnConfirmaClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 556
    Width = 794
    ExplicitTop = 556
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  object grdDados: TcxGridCitel [4]
    Left = 0
    Top = 31
    Width = 794
    Height = 455
    Align = alClient
    TabOrder = 3
    LookAndFeel.ScrollbarMode = sbmClassic
    object grdDadosDados: TcxGridDBTableViewCitel
      Navigator.Buttons.CustomButtons = <>
      OnEditKeyDown = grdDadosDadosEditKeyDown
      OnEditKeyPress = grdDadosDadosEditKeyPress
      DataController.DataSource = dtsDados
      DataController.Filter.Options = [fcoCaseInsensitive]
      DataController.KeyFieldNames = 'ID'
      DataController.MasterKeyFieldNames = 'ID'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      FilterRow.InfoText = 'Clique aqui para definir um filtro'
      FilterRow.ApplyChanges = fracDelayed
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
      OptionsView.GroupByBox = False
      Zebra = True
      Destaque = False
      CorZebra = clMoneyGreen
      object grdDadosDadosPESQUISA: TcxGridDBColumn
        Caption = 'C'#243'digo (Autcom)'
        MinWidth = 100
        Width = 100
      end
      object grdDadosDadosCODIGO: TcxGridDBColumn
        Caption = 'C'#243'digo (Anterior)'
        MinWidth = 100
        Options.Editing = False
        Width = 100
      end
      object grdDadosDadosDESCRI: TcxGridDBColumn
        Caption = 'Descri'#231#227'o'
        MinWidth = 400
        Options.Editing = False
        Width = 400
      end
      object grdDadosDadosTIPOPE: TcxGridDBColumn
        Caption = 'Opera'#231#227'o'
        OnGetDataText = grdDadosDadosTIPOPEGetDataText
        MinWidth = 75
      end
    end
    object grdDadosLvl1: TcxGridLevel
      GridView = grdDadosDados
    end
  end
  object pnlCabecalho: TPanel [5]
    Left = 0
    Top = 0
    Width = 794
    Height = 31
    Align = alTop
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 4
    object lblDetalhes: TLabel
      Left = 15
      Top = 7
      Width = 209
      Height = 14
      Caption = 'DETALHE TABELA "GRUPO DE PRODUTOS"'
    end
  end
  object dtsDados: TDataSource
    Left = 504
    Top = 136
  end
end
