inherited frmDigEmailPedOrcEditor: TfrmDigEmailPedOrcEditor
  Width = 600
  Height = 500
  Caption = 'Digita'#231#227'o do e-mail'
  ExplicitWidth = 600
  ExplicitHeight = 500
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 427
    Width = 594
    TabOrder = 1
    ExplicitTop = 427
    ExplicitWidth = 594
    inherited FlwBotoes: TFlowPanel
      Width = 590
      TabOrder = 2
      ExplicitTop = 2
      ExplicitWidth = 590
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 507
      ExplicitLeft = 507
    end
    object btnConfirma: TBitBtnLocked
      Left = 6
      Top = 3
      Width = 77
      Height = 22
      Caption = '&Confirma'
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
  end
  object pnlPrincipal: TPanel [2]
    Left = 0
    Top = 0
    Width = 594
    Height = 427
    Align = alClient
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblInformarOutrosEmails: TLabel
      Left = 8
      Top = 163
      Width = 257
      Height = 14
      Caption = 'Informar outros e-mails (Separar por ponto e v'#237'rgula):'
    end
    object lblEmails: TLabel
      Left = 8
      Top = 183
      Width = 45
      Height = 14
      Caption = 'E-mail(s):'
    end
    object chkAnexar: TCheckBox
      Left = 391
      Top = 160
      Width = 193
      Height = 17
      Alignment = taLeftJustify
      Caption = 'Anexar foto dos produtos no e-mail'
      TabOrder = 0
    end
    object gbExporta: TGroupBox
      Left = 6
      Top = 205
      Width = 280
      Height = 48
      Caption = 'Exportar'
      TabOrder = 2
      object lblPdfExc: TColorLabel
        Left = 36
        Top = 21
        Width = 71
        Height = 14
        AutoSize = False
        Caption = '(P)df  (E)xcel'
        CorDestaque = clRed
      end
      object edtTipExp: TEditFocus
        Tag = 99
        Left = 15
        Top = 17
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'P'
        OnChange = edtTipExpChange
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object grpOpcExcel: TGroupBox
      Left = 6
      Top = 255
      Width = 578
      Height = 169
      Caption = 'Op'#231#245'es para Exporta'#231#227'o - Excel'
      TabOrder = 4
      object rdgNomEmp: TRadioGroup
        Left = 7
        Top = 17
        Width = 270
        Height = 54
        Caption = 'Nome da Empresa Imprimir:'
        Columns = 2
        Enabled = False
        ItemIndex = 0
        Items.Strings = (
          'Raz'#227'o Social'
          'Nome Fantasia')
        TabOrder = 0
      end
      object gpbOrdem: TGroupBox
        Left = 299
        Top = 17
        Width = 270
        Height = 54
        Caption = 'Ordem'
        TabOrder = 1
        object lbl1: TColorLabel
          Left = 29
          Top = 17
          Width = 188
          Height = 14
          Caption = '(1)Digita'#231#227'o    (2)Descri'#231#227'o do Produto'
          Enabled = False
          CorDestaque = clRed
        end
        object lbl2: TColorLabel
          Left = 29
          Top = 33
          Width = 108
          Height = 14
          Caption = '(3) Unidade de Medida'
          Enabled = False
          CorDestaque = clRed
        end
        object edtOrdem: TEditFocus
          Tag = 99
          Left = 8
          Top = 21
          Width = 18
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 0
          Text = '1'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttInteiro
        end
      end
      object grpDadosPedCd: TGroupBox
        AlignWithMargins = True
        Left = 7
        Top = 74
        Width = 562
        Height = 51
        Caption = 'Imprimir os dados da empresa referente '#224' empresa do:'
        TabOrder = 2
        object lbl3: TColorLabel
          Left = 29
          Top = 18
          Width = 86
          Height = 14
          Caption = '(1) Pr'#243'prio Pedido'
          CorDestaque = clRed
        end
        object lbl4: TColorLabel
          Left = 29
          Top = 30
          Width = 31
          Height = 14
          Caption = '(2) CD'
          CorDestaque = clRed
        end
        object edtEmpCab: TEditFocus
          Tag = 99
          Left = 8
          Top = 20
          Width = 18
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 0
          Text = '1'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttInteiro
        end
      end
      object grpImpMarcaLocFis: TGroupBox
        AlignWithMargins = True
        Left = 7
        Top = 131
        Width = 280
        Height = 34
        TabOrder = 3
        object chkMarca: TCheckBox
          Left = 9
          Top = 9
          Width = 97
          Height = 17
          Caption = 'Imprimir Marca'
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
      end
      object gpbModo: TGroupBox
        AlignWithMargins = True
        Left = 289
        Top = 125
        Width = 280
        Height = 40
        Caption = 'Modo'
        TabOrder = 4
        object clblModo: TColorLabel
          Left = 29
          Top = 18
          Width = 106
          Height = 14
          Caption = '(R)etrato   (P)aisagem'
          Enabled = False
          CorDestaque = clRed
        end
        object edtModo: TEditFocus
          Tag = 99
          Left = 8
          Top = 14
          Width = 18
          Height = 22
          Alignment = taLeftJustify
          CharCase = ecUpperCase
          Enabled = False
          ImeName = 'Portugu'#234's (Brasil ABNT)'
          MaxLength = 1
          TabOrder = 0
          Text = 'R'
          NormalColor = clWindow
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 1
          TipoTexto = ttAlfabetico
        end
      end
    end
    object gbPreco: TGroupBox
      Left = 304
      Top = 205
      Width = 280
      Height = 48
      Caption = 'Pre'#231'o'
      TabOrder = 3
      object lbl5: TColorLabel
        Left = 29
        Top = 23
        Width = 129
        Height = 14
        Caption = '(C)om Pre'#231'o   (S)em Pre'#231'o'
        CorDestaque = clRed
      end
      object edtPreco: TEditFocus
        Tag = 99
        Left = 8
        Top = 20
        Width = 18
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 1
        TabOrder = 0
        Text = 'C'
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfabetico
      end
    end
    object grpContatos: TGroupBox
      Left = 6
      Top = 4
      Width = 578
      Height = 155
      TabOrder = 5
      object grdContatos: TcxGridCitel
        Left = 2
        Top = 16
        Width = 574
        Height = 137
        Align = alClient
        TabOrder = 0
        LookAndFeel.ScrollbarMode = sbmClassic
        object grdContatosDados: TcxGridDBTableViewCitel
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = dtsContatos
          DataController.Filter.Options = [fcoCaseInsensitive]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          FilterRow.InfoText = 'Clique aqui para definir um filtro'
          FilterRow.ApplyChanges = fracDelayed
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.FocusRect = False
          OptionsView.NoDataToDisplayInfoText = 'Sem dados para exibir'
          OptionsView.GroupByBox = False
          Zebra = False
          Destaque = False
          CorZebra = clMoneyGreen
          object grdContatosDadosSELCTT: TcxGridDBColumn
            DataBinding.FieldName = 'SELCTT'
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ValueChecked = 'S'
            Properties.ValueUnchecked = 'N'
            Width = 26
            IsCaptionAssigned = True
          end
          object grdContatosDadosNOMCTT: TcxGridDBColumn
            DataBinding.FieldName = 'NOMCTT'
            Options.Editing = False
            Width = 175
          end
          object grdContatosDadosDEPCTT: TcxGridDBColumn
            DataBinding.FieldName = 'DEPCTT'
            Options.Editing = False
            Width = 175
          end
          object grdContatosDadosEMACTT: TcxGridDBColumn
            Caption = 'E-mail'
            DataBinding.FieldName = 'EMACTT'
            Options.Editing = False
            Width = 175
          end
        end
        object grdContatosNivel: TcxGridLevel
          GridView = grdContatosDados
        end
      end
    end
    object edtOutrosEmails: TEditFocus
      Tag = 99
      Left = 56
      Top = 180
      Width = 528
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
  end
  inherited pnlStatus: TPanel
    Top = 455
    Width = 594
    TabOrder = 2
    ExplicitTop = 455
    ExplicitWidth = 594
    inherited pnlNomeForm: TPanel
      Left = 423
      ExplicitLeft = 423
    end
    inherited pnlInfo: TPanel
      Width = 423
      ExplicitWidth = 423
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 412
    Top = 312
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 376
    Top = 312
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 304
    Top = 312
  end
  object cdsContatos: TUniClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 312
    object cdsContatosSELCTT: TStringField
      FieldName = 'SELCTT'
      Size = 1
    end
    object cdsContatosNOMCTT: TStringField
      DisplayLabel = 'Contato'
      FieldName = 'NOMCTT'
      Size = 255
    end
    object cdsContatosDEPCTT: TStringField
      DisplayLabel = 'Departamento'
      FieldName = 'DEPCTT'
      Size = 255
    end
    object cdsContatosEMACTT: TStringField
      DisplayLabel = 'e-mail'
      FieldName = 'EMACTT'
      Size = 255
    end
  end
  object dtsContatos: TDataSource
    DataSet = cdsContatos
    Left = 268
    Top = 312
  end
end
