inherited frmFatAltQtdeItensPedido: TfrmFatAltQtdeItensPedido
  Left = 482
  Top = 194
  Width = 857
  Height = 450
  BorderIcons = [biSystemMenu]
  Caption = 'Altera'#231#227'o do Pedido de Venda'
  Position = poMainFormCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 857
  ExplicitHeight = 450
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlStatus: TPanel [0]
    Top = 405
    Width = 851
    TabOrder = 4
    ExplicitTop = 405
    ExplicitWidth = 833
    inherited pnlInfo: TPanel [0]
      Width = 680
      ExplicitWidth = 662
    end
    inherited pnlNomeForm: TPanel [1]
      Left = 680
      ExplicitLeft = 662
    end
  end
  object pnlBusca: TPanel [1]
    Left = 0
    Top = 0
    Width = 851
    Height = 57
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    ExplicitWidth = 833
    object lbl1: TLabel
      Left = 13
      Top = 9
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#186' Pedido:'
    end
    object lbl2: TLabel
      Left = 130
      Top = 7
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 13
      Top = 24
      Width = 87
      Height = 22
      Alignment = taLeftJustify
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      MaxLength = 12
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 130
      Top = 24
      Width = 53
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      MaxLength = 3
      ReadOnly = True
      TabOrder = 2
      Text = '001'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 100
      Top = 24
      Width = 28
      Height = 22
      TabStop = False
      Alignment = taCenter
      CharCase = ecUpperCase
      Color = 16768952
      MaxLength = 2
      ReadOnly = True
      TabOrder = 1
      Text = 'PD'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtDesEmp: TEditFocus
      Left = 183
      Top = 24
      Width = 391
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      ReadOnly = True
      TabOrder = 3
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDados: TPanel [2]
    Left = 0
    Top = 57
    Width = 851
    Height = 178
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    Enabled = False
    TabOrder = 5
    ExplicitWidth = 833
    object pnlForPagAtu: TPanel
      Left = 2
      Top = 130
      Width = 847
      Height = 45
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 2
      ExplicitWidth = 829
      object lbl7: TLabel
        Left = 11
        Top = 1
        Width = 60
        Height = 14
        Alignment = taRightJustify
        Caption = 'Form. Pagto:'
      end
      object edtForPagAtu: TEditFocus
        Tag = 99
        Left = 11
        Top = 16
        Width = 65
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesFpgAtu: TEditFocus
        Left = 77
        Top = 16
        Width = 495
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
    end
    object pnl2: TPanel
      Left = 2
      Top = 89
      Width = 847
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      ExplicitWidth = 829
      object lbl8: TLabel
        Left = 11
        Top = 1
        Width = 61
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cond. Pagto:'
      end
      object edtCodCndAtu: TEditFocus
        Tag = 99
        Left = 11
        Top = 16
        Width = 65
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        Color = 16768952
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttAlfanumerico
      end
      object mskCndPagAtu: TMaskEditFocus
        Tag = 99
        Left = 77
        Top = 16
        Width = 524
        Height = 22
        TabStop = False
        CharCase = ecUpperCase
        Color = 16768952
        EditMask = 
          '99.999.999.999.999.999.999.999.999.999.999.999.999.999.999.999.9' +
          '99.999.999.999.999.999.999.999.999;0;'
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 98
        ReadOnly = True
        TabOrder = 2
        Text = ''
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = False
      end
      object edtDesCndAtu: TEditFocus
        Left = 604
        Top = 16
        Width = 196
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
    end
    object pnl3: TPanel
      Left = 2
      Top = 2
      Width = 847
      Height = 87
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      ExplicitWidth = 829
      object lbl4: TLabel
        Left = 11
        Top = 7
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object lbl5: TLabel
        Left = 693
        Top = 7
        Width = 25
        Height = 14
        Alignment = taRightJustify
        Caption = 'Data:'
      end
      object lbl6: TLabel
        Left = 695
        Top = 47
        Width = 53
        Height = 14
        Alignment = taRightJustify
        Caption = 'Valor Total:'
      end
      object lbl3: TLabel
        Left = 12
        Top = 47
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 11
        Top = 21
        Width = 65
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 5
        ReadOnly = True
        TabOrder = 0
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDtaEnt: TEditFocus
        Tag = 99
        Left = 693
        Top = 21
        Width = 107
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 3
        ReadOnly = True
        TabOrder = 1
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtDesCli: TEditFocus
        Left = 77
        Top = 21
        Width = 612
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        ReadOnly = True
        TabOrder = 2
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtValDocAtu: TEditFocus
        Tag = 2
        Left = 693
        Top = 61
        Width = 107
        Height = 22
        TabStop = False
        Alignment = taRightJustify
        Color = 16768952
        MaxLength = 12
        ReadOnly = True
        TabOrder = 3
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
      end
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 11
        Top = 61
        Width = 65
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        MaxLength = 5
        ReadOnly = True
        TabOrder = 4
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 5
        TipoTexto = ttNumerico
      end
      object edtDesVen: TEditFocus
        Left = 77
        Top = 61
        Width = 612
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
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
  end
  object pnlItens: TPanel [3]
    Left = 0
    Top = 235
    Width = 851
    Height = 142
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 1
    ExplicitWidth = 833
    object dbgItens: TDBGridCitel
      Left = 0
      Top = 0
      Width = 851
      Height = 142
      Hint = 
        'ESC: Voltar ao c'#243'digo do item'#13#10'ENTER: Alterar Item'#13#10'DELETE: Dele' +
        'ta o item'#13#10'CTRL + CIMA: Mover item para cima'#13#10'CTRL + BAIXO: Move' +
        'r item para baixo'
      Align = alClient
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgEditing, dgTitles, dgIndicator, dgColLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgItensDrawColumnCell
      OnEnter = dbgItensEnter
      OnKeyPress = dbgItensKeyPress
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Expanded = False
          FieldName = 'ITE_CODITE'
          ReadOnly = True
          Title.Caption = 'C'#243'digo'
          Width = 50
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_DESITE'
          ReadOnly = True
          Title.Caption = 'Descri'#231#227'o'
          Width = 346
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_SIGUNI'
          ReadOnly = True
          Title.Caption = 'Unid.'
          Width = 29
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_QTDEXP'
          ReadOnly = True
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtde. Exp.'
          Width = 70
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'ITE_QTDITE'
          Title.Alignment = taRightJustify
          Title.Caption = 'Qtde. Ped.'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_SALDIS'
          Title.Caption = 'Saldo Disp.'
          Width = 73
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_ENTDSC'
          ReadOnly = True
          Title.Caption = 'Ent./Ret.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ITE_DTENTR'
          ReadOnly = True
          Title.Caption = 'Data de Entrega'
          Width = 94
          Visible = True
        end>
    end
    object dtDataEntrega: TDateTimePicker
      Left = 600
      Top = 88
      Width = 186
      Height = 22
      Date = 44036.624801979170000000
      Time = 44036.624801979170000000
      TabOrder = 1
      Visible = False
      OnChange = dtDataEntregaChange
      OnExit = dtDataEntregaExit
    end
  end
  inherited pnlBotoes: TPanel
    Top = 377
    Width = 851
    TabOrder = 3
    ExplicitTop = 377
    ExplicitWidth = 833
    inherited FlwBotoes: TFlowPanel
      Width = 847
      TabOrder = 2
      ExplicitWidth = 829
    end
    inherited btnSair: TBitBtnLocked
      Left = 768
      ExplicitLeft = 750
    end
    object btnConfirma: TBitBtnLocked
      Left = 5
      Top = 3
      Width = 102
      Height = 22
      Caption = '[F10] &Confirma'
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
      OnErro = btnConfirmaErro
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 328
    Top = 8
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 360
    Top = 8
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 296
    Top = 8
  end
end
