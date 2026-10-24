inherited frmFatRomaneioAdicionarDoctosNaoEntregues: TfrmFatRomaneioAdicionarDoctosNaoEntregues
  Width = 1024
  Height = 768
  Caption = 'Adicionar documentos n'#227'o entregues ao Pr'#233'-Romaneio'
  Position = poScreenCenter
  ExplicitWidth = 1024
  ExplicitHeight = 768
  PixelsPerInch = 96
  TextHeight = 14
  object splitter: TSplitter [0]
    Left = 0
    Top = 382
    Width = 1018
    Height = 5
    Cursor = crVSplit
    Align = alBottom
    AutoSnap = False
    Beveled = True
    ResizeStyle = rsUpdate
    OnCanResize = splitterCanResize
    ExplicitLeft = -2
    ExplicitTop = 371
  end
  inherited pnlBotoes: TPanel
    Top = 695
    Width = 1018
    ExplicitTop = 695
    ExplicitWidth = 1018
    inherited FlwBotoes: TFlowPanel
      Width = 1014
      ExplicitWidth = 1014
      object btnCancelar: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 116
        Height = 22
        Align = alLeft
        Caption = '[ F3 ] Cancelar'
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
        OnClick = btnCancelarClick
      end
      object btnConfirma: TBitBtnLocked
        Left = 116
        Top = 0
        Width = 127
        Height = 22
        Align = alLeft
        Caption = '[ F10 ] Confirmar'
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
        TabOrder = 1
        OnClick = btnConfirmaClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 935
      ExplicitLeft = 935
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
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 1018
    Height = 56
    Align = alTop
    Color = 16770261
    ParentBackground = False
    TabOrder = 2
    object lblRomaneio: TLabel
      Left = 8
      Top = 7
      Width = 82
      Height = 14
      Caption = 'N'#186' Pr'#233'-Romaneio'
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
      OnEnter = edtNumRomEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 13
      TipoTexto = ttNumerico
    end
  end
  object pnlDocsAnt: TPanel [4]
    Left = 0
    Top = 56
    Width = 1018
    Height = 326
    Align = alClient
    Caption = 'pnlDocsAnt'
    ParentColor = True
    TabOrder = 3
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 1016
      Height = 17
      Align = alTop
      Caption = 'Documentos do Pr'#233'-Romaneio'
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
      Height = 273
      Align = alClient
      BevelInner = bvLowered
      BorderWidth = 2
      TabOrder = 1
      LookAndFeel.ScrollbarMode = sbmClassic
      object cxgDocsAntDados: TcxGridDBTableView
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
      Top = 291
      Width = 1016
      Height = 34
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      object Label4: TLabel
        Left = 8
        Top = 11
        Width = 65
        Height = 14
        Caption = 'N'#186' NF Venda:'
      end
      object Label5: TLabel
        Left = 224
        Top = 11
        Width = 362
        Height = 14
        Caption = 
          'Digite o n'#250'mero do documento de Venda para adicion'#225'-lo ao Pr'#233'-Ro' +
          'maneio.'
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
        Left = 77
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
    Top = 387
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
      Caption = 'Documentos que ser'#227'o adicionados para nova entrega'
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
  inherited mnuAuxiliar: TPopupMenu
    Left = 400
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 248
    Top = 8
  end
  object dtsDocsAnt: TDataSource
    Left = 487
    Top = 8
  end
  object dtsDocsNov: TDataSource
    Left = 567
    Top = 8
  end
end
