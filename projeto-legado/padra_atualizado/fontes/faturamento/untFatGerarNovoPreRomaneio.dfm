inherited frmFatGerarNovoPreRomaneio: TfrmFatGerarNovoPreRomaneio
  Left = 148
  Top = 137
  Width = 1024
  Height = 768
  Caption = 'Gerar Novo Pr'#233'-Romaneio'
  Position = poScreenCenter
  OnClose = FormClose
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  object splitter: TSplitter [0]
    Left = 0
    Top = 381
    Width = 1018
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Beveled = True
    ResizeStyle = rsUpdate
    OnCanResize = splitterCanResize
    ExplicitTop = 384
  end
  inherited pnlBotoes: TPanel
    Top = 694
    Width = 1018
    Height = 29
    TabOrder = 2
    ExplicitTop = 694
    ExplicitWidth = 1018
    ExplicitHeight = 29
    inherited FlwBotoes: TFlowPanel
      Left = 521
      Width = 393
      Height = 25
      TabOrder = 3
    end
    inherited btnSair: TBitBtnLocked
      Left = 914
      Top = 2
      Width = 102
      Height = 25
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 914
      ExplicitTop = 2
      ExplicitWidth = 102
      ExplicitHeight = 25
    end
    object btnConfirma: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 271
      Height = 25
      Align = alLeft
      Caption = '[ F10 ] Confirmar Gera'#231#227'o de Novo Pr'#233'-Romaneio'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FF313131313131313131313131FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF313131746B6D7A767674
        7575828282313131313131313131FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF313131726E726A66697D797A2929293838384242422828286868683131
        31313131313131FF00FFFF00FFFF00FF3131316F6C6F7470746D6A6D7D797B6C
        6D6D4C4C4C1F1F1F000000000000090909757274777277424141FF00FF313131
        CCCACEC9C4C9999398696669E5E2E5D8D9D9ACACAC8E8E8E525252232323201F
        203D483D3C563C424141313131929193D7D5D9D7D5D8F2F4F68082846D6C6DA4
        A3A4D8D8D8E9EBEBE3EAEAD4D9D9ADACAF6F836F388239424141313131EFEEF2
        E5E5E9F7F6F6CFACACC4A6A99296986A6B6C5152536D6364A78384C4ADAFD3D0
        D1E6E3E5D8D8D8424141313131FCFCFCFEFFFFCA9895B43837934041826263BF
        ACABD0D0D1B588887D12119C3C3D766D6E6E6869626060FF00FF313131FFFFFF
        FFFFFF9F3536BC4242A355557F2A28AC6C6BFFFFFFD1A4A47B14149F35362D2C
        2C2D2C2CFF00FFFF00FF3F3F3F313131CACECF9F3536BD4241AB53539A545389
        5354CAC5C2CC92928217179F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        3131319F3536B84442B64F4FC16968BC6363B85959BD5E5DBF58589F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536B5635FE9D5D4EEDEDDEF
        DDDCEEDAD9F2E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47E7AF3FBF8C5C2C1C5C2C1C5C2C1E7EBEBC47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9F3536C17A78F3F3F3DDD8D7DD
        D8D7DDD8D7E3E6E5C47B799F3536FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF9F3536C47B79F3F3F3C5C2C1C5C2C1C5C2C1E3E6E5C47B799F3536FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB1706ECCC6C6CCC6C6CC
        C6C6CCC6C6CCC6C6B1706EFF00FFFF00FFFF00FFFF00FFFF00FF}
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
    object btnCancelar: TBitBtnLocked
      Left = 273
      Top = 2
      Width = 248
      Height = 25
      Align = alLeft
      Caption = '[ F3 ] Cancelar Gera'#231#227'o Novo Pr'#233'-Romaneio'
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
      OnClick = btnCancelarClick
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 56
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblRomaneio: TLabel
      Left = 8
      Top = 7
      Width = 62
      Height = 14
      Caption = 'N'#186' Romaneio'
    end
    object Label3: TLabel
      Left = 160
      Top = 18
      Width = 461
      Height = 29
      AutoSize = False
      Caption = 
        'Digite o n'#250'mero do Pr'#233'-Romaneio e pressione [Enter] para carrega' +
        'r os documentos do mesmo. Poder'#227'o ser carregados v'#225'rios Pr'#233'-Roma' +
        'neios.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object edtNumRom: TEditFocus
      Tag = 99
      Left = 8
      Top = 21
      Width = 141
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 13
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 13
      TipoTexto = ttNumerico
    end
    object btnIncluirRomNaoAti: TBitBtnLocked
      Left = 792
      Top = 10
      Width = 214
      Height = 38
      Caption = '[F5] Incluir Todos os Romaneios N'#227'o Ativados / J'#225' Faturados'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000002000000070000
        000D0000000F0000000D00000007000000020000000000000000000000020000
        00090000000F00000010000000110000001100000014020101214C28168E8648
        27DAA55831FF854627DB4A28158C020100150000000400000000000000098B63
        56C1C18977FFC08976FFC08875FFC59584FFCFAFA3FFB0704EFFC07C4AFFDEA6
        69FFF4D3A1FFDEA76AFFBF7C4BFF844728D406030217000000020000000CC38E
        79FFFDFBFAFFFBF7F4FFFCF6F3FFF7F4F1FFC8A28CFFC48656FFEDBC7CFFEEBF
        7FFF83400EFFF2CC94FFEFC181FFC38657FF58321C93000000070000000DC591
        7EFFFDFCFBFFF8EFE8FFF7EEE8FFF2EDE9FFBA7D57FFE4B377FFF5D9ABFFF5DA
        AFFF8B4914FFF7E3BEFFF6DBB2FFE5B77FFF995C36E30000000B0000000CC794
        81FFFEFCFBFFF9F0EAFFF8F0EAFFF3EFECFFBC784FFFF1CE95FF995420FF9752
        1DFF934F1CFF904C19FF8D4917FFF5DBAEFFB16F45FA0000000B0000000BC997
        86FFFEFDFCFFF9F2EDFFF9F2EDFFF5F0EDFFC68C65FFEFDDB7FFF3CF98FFF5D5
        9FFF9B5622FFF7E0B2FFF5D7A4FFEFDDB8FFA46942E2000000080000000ACB9C
        8BFFFEFDFDFFFAF3EFFFFAF4EEFFF8F3F0FFDBB9A4FFD8AE86FFF9F3D1FFF8E1
        B5FFA35D28FFFAEAC6FFFAF6D5FFD8AF89FF5E3E29850000000400000009CFA0
        8DFFFEFEFDFFFBF5F1FFFBF5F0FFFAF4F1FFF6F2EFFFD5A785FFDCB48DFFF2E9
        CAFFFAFDE1FFF2E9CAFFDCB38CFF996B4AC80202010A0000000100000009D0A3
        93FFFEFEFDFFFAF5F3FFFBF6F2FFFBF5F1FFFBF6F2FFF8F4F0FFE4C9B4FFDAAF
        8AFFD8A578FFDBAE8AFFD7B098FF02020117000000010000000000000008D3A8
        97FFFEFEFEFFFBF6F4FFFBF6F4FFFCF6F3FFFCF6F3FFFCF5F4FFFAF6F3FFFAF6
        F3FFF8F6F3FFFBF9F8FFDAB9ADFF0000000E000000000000000000000007D3AB
        9AFFFFFEFEFFFCF8F6FFFCF7F5FFFCF7F5FFFBF6F4FFFBF6F4FFFCF6F3FFFCF6
        F2FFFBF6F1FFFDFBF9FFD0A493FF0000000C000000000000000000000006D8AE
        9DFFFFFFFEFFFDF9F7FFFDF9F7FFFCF8F7FFFCF8F6FFFCF7F5FFFBF7F5FFFBF7
        F4FFFCF7F3FFFDFCFAFFD2A897FF0000000B000000000000000000000006D8B0
        A0FFFFFFFFFFFDFAF9FFFDFAF8FFFDFAF8FFFDF9F7FFFCF8F7FFFBF8F6FFFBF7
        F6FFFCF7F5FFFEFCFCFFD5AA9AFF0000000B000000000000000000000005D9B3
        A3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFEFEFFFEFEFEFFFFFEFEFFFEFE
        FEFFFEFEFEFFFEFEFDFFD7AE9EFF00000009000000000000000000000003A386
        7AC0DBB5A5FFDAB5A4FFDAB5A4FFDAB4A4FFD9B3A3FFD9B3A3FFD9B3A2FFD9B2
        A2FFD8B2A2FFD8B1A1FFA08277C2000000060000000000000000}
      TabOrder = 1
      WordWrap = True
      OnClick = btnIncluirRomNaoAtiClick
    end
  end
  object pnlDocsAnt: TPanel [4]
    Left = 0
    Top = 56
    Width = 1018
    Height = 325
    Align = alClient
    Caption = 'pnlDocsAnt'
    ParentColor = True
    TabOrder = 3
    object Label1: TLabel
      Left = 1
      Top = 276
      Width = 1016
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 'Pressione [ ESPA'#199'O ] sobre um documento para selecionar o mesmo.'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitWidth = 387
    end
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 17
      Align = alTop
      Caption = 'Documentos do(s) Pr'#233'-Romaneio(s)'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
    end
    object cxgDocsAnt: TcxGrid
      Left = 1
      Top = 18
      Width = 1016
      Height = 258
      Align = alClient
      BevelInner = bvLowered
      BorderWidth = 2
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDocsAntDados: TcxGridDBTableView
        OnKeyDown = cxgDocsAntDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = True
        Navigator.Buttons.PriorPage.Visible = True
        Navigator.Buttons.Prior.Visible = True
        Navigator.Buttons.Next.Visible = True
        Navigator.Buttons.NextPage.Visible = True
        Navigator.Buttons.Last.Visible = True
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Visible = True
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = True
        Navigator.Buttons.SaveBookmark.Visible = True
        Navigator.Buttons.GotoBookmark.Visible = True
        Navigator.Buttons.Filter.Visible = True
        FilterBox.CustomizeDialog = False
        DataController.DataSource = dtsDocsAnt
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
          end
          item
            Format = '#,##0.00'
            Kind = skSum
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00;(,0.00)'
            Kind = skSum
            DisplayText = 'Total'
          end
          item
            Kind = skCount
            DisplayText = 'Qtd. Cheques'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para filtrar'
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' documentos para serem exibidos'
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxgDocsAntDadosDTAENT: TcxGridDBColumn
          Caption = 'Data Entrada'
          DataBinding.FieldName = 'DTAENT'
          Width = 78
        end
        object cxgDocsAntDadosNUMROM: TcxGridDBColumn
          Caption = 'Romaneio'
          DataBinding.FieldName = 'NUMROM'
          Width = 69
        end
        object cxgDocsAntDadosNUMPED: TcxGridDBColumn
          Caption = 'N'#186' Pedido'
          DataBinding.FieldName = 'NUMPED'
          Width = 111
        end
        object cxgDocsAntDadosNUMFAT: TcxGridDBColumn
          Caption = 'N'#186' Venda'
          DataBinding.FieldName = 'NUMFAT'
          Width = 128
        end
        object cxgDocsAntDadosNOMCLI: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'NOMCLI'
          Width = 179
        end
        object cxgDocsAntDadosNOMCID: TcxGridDBColumn
          Caption = 'Cidade'
          DataBinding.FieldName = 'NOMCID'
          Width = 153
        end
        object cxgDocsAntDadosCODVEN: TcxGridDBColumn
          Caption = 'Vend.'
          DataBinding.FieldName = 'CODVEN'
          Width = 51
        end
        object cxgDocsAntDadosNOMTRA: TcxGridDBColumn
          Caption = 'Transportadora'
          DataBinding.FieldName = 'NOMTRA'
          Width = 120
        end
        object cxgDocsAntDadosVLRCON: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VLRCON'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 80
        end
      end
      object cxgDocsAntNivel: TcxGridLevel
        GridView = cxgDocsAntDados
      end
    end
    object pnlDocVen: TPanel
      Left = 1
      Top = 290
      Width = 1016
      Height = 34
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      Visible = False
      object Label4: TLabel
        Left = 8
        Top = 11
        Width = 49
        Height = 14
        Caption = 'N'#186' Venda:'
      end
      object Label5: TLabel
        Left = 210
        Top = 11
        Width = 389
        Height = 14
        Caption = 
          'Digite o n'#250'mero do documento de Venda para adicion'#225'-lo ao novo P' +
          'r'#233'-Romaneio.'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = 14
        Font.Name = 'Arial'
        Font.Pitch = fpVariable
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object edtNFVend: TEditFocus
        Tag = 99
        Left = 63
        Top = 6
        Width = 141
        Height = 22
        Alignment = taLeftJustify
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 6
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 6
        TipoTexto = ttNumerico
      end
    end
  end
  object pnlDocsNov: TPanel [5]
    Left = 0
    Top = 386
    Width = 1018
    Height = 308
    Align = alBottom
    Caption = 'pnlDocsNov'
    ParentColor = True
    TabOrder = 4
    object Label2: TLabel
      Left = 1
      Top = 293
      Width = 1016
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 'Pressione [ DELETE ] sobre um documento para remover o mesmo.'
      Color = clWhite
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
      Layout = tlCenter
      ExplicitWidth = 373
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 17
      Align = alTop
      Caption = 'Documentos Novo Pr'#233'-Romaneio'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentColor = True
      ParentFont = False
      TabOrder = 0
    end
    object cxgDocsNov: TcxGrid
      Left = 1
      Top = 18
      Width = 1016
      Height = 275
      Align = alClient
      BevelInner = bvLowered
      BorderWidth = 2
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDocsNovDados: TcxGridDBTableView
        OnKeyDown = cxgDocsNovDadosKeyDown
        Navigator.Buttons.CustomButtons = <>
        Navigator.Buttons.First.Visible = True
        Navigator.Buttons.PriorPage.Visible = True
        Navigator.Buttons.Prior.Visible = True
        Navigator.Buttons.Next.Visible = True
        Navigator.Buttons.NextPage.Visible = True
        Navigator.Buttons.Last.Visible = True
        Navigator.Buttons.Insert.Visible = True
        Navigator.Buttons.Append.Visible = False
        Navigator.Buttons.Delete.Visible = True
        Navigator.Buttons.Edit.Visible = True
        Navigator.Buttons.Post.Visible = True
        Navigator.Buttons.Cancel.Visible = True
        Navigator.Buttons.Refresh.Visible = True
        Navigator.Buttons.SaveBookmark.Visible = True
        Navigator.Buttons.GotoBookmark.Visible = True
        Navigator.Buttons.Filter.Visible = True
        FilterBox.CustomizeDialog = False
        DataController.DataSource = dtsDocsNov
        DataController.Summary.DefaultGroupSummaryItems = <
          item
            Format = '#,##0.00'
            Kind = skSum
            Position = spFooter
          end
          item
            Format = '#,##0.00'
            Kind = skSum
          end>
        DataController.Summary.FooterSummaryItems = <
          item
            Format = ',0.00;(,0.00)'
            Kind = skSum
            DisplayText = 'Total'
          end
          item
            Kind = skCount
            DisplayText = 'Qtd. Cheques'
          end
          item
            Format = '#,##0.00'
            Kind = skSum
          end>
        DataController.Summary.SummaryGroups = <>
        FilterRow.InfoText = 'Clique aqui para filtrar'
        FilterRow.ApplyChanges = fracImmediately
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Editing = False
        OptionsData.Inserting = False
        OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' documentos para serem exibidos'
        OptionsView.GroupByBox = False
        OptionsView.Indicator = True
        object cxGridDBColumn1: TcxGridDBColumn
          Caption = 'Data Entrada'
          DataBinding.FieldName = 'DTAENT'
          Width = 78
        end
        object cxGridDBColumn2: TcxGridDBColumn
          Caption = 'Romaneio'
          DataBinding.FieldName = 'NUMROM'
          Width = 69
        end
        object cxGridDBColumn3: TcxGridDBColumn
          Caption = 'N'#186' Pedido'
          DataBinding.FieldName = 'NUMPED'
          Width = 122
        end
        object cxGridDBColumn4: TcxGridDBColumn
          Caption = 'N'#186' Venda'
          DataBinding.FieldName = 'NUMFAT'
          Width = 154
        end
        object cxGridDBColumn5: TcxGridDBColumn
          Caption = 'Cliente'
          DataBinding.FieldName = 'NOMCLI'
          Width = 171
        end
        object cxGridDBColumn6: TcxGridDBColumn
          Caption = 'Cidade'
          DataBinding.FieldName = 'NOMCID'
          Width = 127
        end
        object cxGridDBColumn7: TcxGridDBColumn
          Caption = 'Vend.'
          DataBinding.FieldName = 'CODVEN'
          Width = 51
        end
        object cxGridDBColumn8: TcxGridDBColumn
          Caption = 'Transportadora'
          DataBinding.FieldName = 'NOMTRA'
          Width = 120
        end
        object cxGridDBColumn9: TcxGridDBColumn
          Caption = 'Valor'
          DataBinding.FieldName = 'VLRCON'
          FooterAlignmentHorz = taRightJustify
          GroupSummaryAlignment = taRightJustify
          HeaderAlignmentHorz = taRightJustify
          HeaderGlyphAlignmentHorz = taRightJustify
          Width = 80
        end
      end
      object cxgDocsNovNivel: TcxGridLevel
        GridView = cxgDocsNovDados
      end
    end
  end
  inherited pnlStatus: TPanel
    Top = 723
    Width = 1018
    ExplicitTop = 723
    ExplicitWidth = 1018
    inherited pnlNomeForm: TPanel
      Left = 847
      ExplicitLeft = 847
    end
    inherited pnlInfo: TPanel
      Width = 847
      ExplicitWidth = 847
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 776
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 711
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 744
    Top = 8
  end
  object dtsDocsAnt: TDataSource
    Left = 743
    Top = 480
  end
  object dtsDocsNov: TDataSource
    Left = 775
    Top = 480
  end
end
