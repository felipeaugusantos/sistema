inherited frmFatExpServicos: TfrmFatExpServicos
  Width = 679
  Height = 457
  Caption = 'Expedi'#231#227'o de Servi'#231'os'
  Position = poScreenCenter
  OnDestroy = FormDestroy
  ExplicitWidth = 679
  ExplicitHeight = 457
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 386
    Width = 673
    Height = 26
    TabOrder = 1
    ExplicitTop = 386
    ExplicitWidth = 673
    ExplicitHeight = 26
    inherited FlwBotoes: TFlowPanel
      Width = 592
      Height = 22
      ExplicitTop = 2
      ExplicitWidth = 669
      ExplicitHeight = 22
      object btnExpedir: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 80
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F10 ] Expedir'
        Enabled = False
        TabOrder = 0
        OnClick = btnExpedirClick
      end
      object btnVoltarItens: TBitBtnLocked
        Left = 80
        Top = 0
        Width = 164
        Height = 22
        Anchors = [akRight, akBottom]
        Caption = '[ F9 ] Voltar Itens de um pedido'
        TabOrder = 1
        OnClick = btnVoltarItensClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 594
      Top = 2
      Align = alRight
      ExplicitLeft = 593
      ExplicitTop = 2
    end
  end
  object pnlFundo: TPanel [2]
    Left = 0
    Top = 0
    Width = 673
    Height = 386
    Align = alClient
    BevelOuter = bvNone
    Color = 16770261
    ParentBackground = False
    TabOrder = 0
    object lblInfo: TLabel
      Left = 0
      Top = 372
      Width = 673
      Height = 14
      Align = alBottom
      Caption = ' [Enter] para marcar / desmarcar documento.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 247
    end
    object lblPedSel: TLabel
      Left = 0
      Top = 358
      Width = 673
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 'Pedidos Selecionados: '
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 128
    end
    object dbgPedidos: TDBGridCitel
      Left = 0
      Top = 66
      Width = 673
      Height = 292
      Align = alClient
      DataSource = dtsPedidos
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgPedidosDrawColumnCell
      OnKeyDown = dbgPedidosKeyDown
      CorZebra = clMoneyGreen
      Zebra = False
      DestacarMouse = False
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CODVEN'
          Title.Alignment = taCenter
          Title.Caption = 'Vend.'
          Width = 31
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'DTAENT'
          Title.Alignment = taCenter
          Title.Caption = 'Data Emis.'
          Width = 57
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'HORENT'
          Title.Alignment = taCenter
          Title.Caption = 'Hora Emis.'
          Width = 54
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'NUMDOC'
          Title.Alignment = taCenter
          Title.Caption = 'Documento'
          Width = 96
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'ESPDOC'
          Title.Alignment = taCenter
          Title.Caption = 'Esp.'
          Width = 24
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CODEMP'
          Title.Alignment = taCenter
          Title.Caption = 'Emp. Ori.'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMCLI'
          Title.Caption = 'Cliente'
          Width = 169
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'VLRCON'
          Title.Caption = 'Vr. Vendido'
          Width = 91
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'URGENT'
          Title.Caption = 'Urgente'
          Width = 60
          Visible = True
        end>
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 673
      Height = 66
      Align = alTop
      TabOrder = 0
      object Label3: TLabel
        Left = 5
        Top = 17
        Width = 50
        Height = 14
        Alignment = taRightJustify
        Caption = 'Vendedor:'
      end
      object Label2: TLabel
        Left = 20
        Top = 40
        Width = 35
        Height = 14
        Alignment = taRightJustify
        Caption = 'Cliente:'
      end
      object btnFiltrar: TBitBtnLocked
        Left = 563
        Top = 36
        Width = 85
        Height = 22
        Caption = '&Filtrar'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
          A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
          69A46769A46769FF00FFFF00FFFF00FF485360FEE9C7F4DAB5F3D5AAF2D0A0EF
          CB96EFC68BEDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FF4380B7
          1F6FC2656B86F3DABCF2D5B1F0D0A7EECB9EEDC793EDC28BE9BD81E9BD7FE9BD
          7FEFC481A46769FF00FFFF00FFFF00FF32A3FF1672D76B6A80F2DABCF2D5B2EF
          D0A9EECB9EEDC796EBC28CE9BD82E9BD7FEFC481A46769FF00FFFF00FFFF00FF
          A0675B34A1FF1572D45E6782F3DABBF2D5B1F0D0A6EECB9EEDC795EBC28AEABF
          81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF033A6FF4078AD8E675EAC
          7F7597645EAC7D6FCAA083EDC695EBC28AEFC583A46769FF00FFFF00FFFF00FF
          A7756BFFFFFCFAF0E6AD8A88B78F84D8BAA5EED5B6D7B298B58877CBA083EBC7
          93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFFEF7F2AF847FDAC0B4F7
          E3CFF6E0C5FFFFF4D7B198AC7D6FEECC9EF3CE97A46769FF00FFFF00FFFF00FF
          BC8268FFFFFFFFFEFC976560F6E9E0F7EADAF6E3CFFFFFEBEFD4B797645EF0D0
          A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFFFFFFFFB08884DECAC4FA
          EFE5F8EAD9FFFFD4D9B8A5AC7F74F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
          D1926DFFFFFFFFFFFFD5BFBCBA9793DECAC4F6E9DEDAC0B4B78F84B28C7BDECE
          B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFFFFFFFD5BFBCB0
          8884976560AF867FCAA79DA56B5FA56B5FA56B5FA46769FF00FFFF00FFFF00FF
          DA9D75FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFBFFFEF7DAC1BAA56B5FE19E
          55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
          E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
          6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
          926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
        TabOrder = 4
        OnClick = btnFiltrarClick
      end
      object edtCodVen: TEditFocus
        Tag = 99
        Left = 59
        Top = 13
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 3
        TabOrder = 0
        OnKeyPress = edtCodVenKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 3
        TipoTexto = ttNumerico
      end
      object edtNomVen: TEditFocus
        Left = 125
        Top = 13
        Width = 432
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
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
      object edtCodCli: TEditFocus
        Tag = 99
        Left = 59
        Top = 36
        Width = 65
        Height = 22
        Alignment = taLeftJustify
        CharCase = ecUpperCase
        ImeName = 'Portugu'#234's (Brasil ABNT)'
        MaxLength = 8
        TabOrder = 2
        OnKeyPress = edtCodCliKeyPress
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = True
        TamCampo = 8
        TipoTexto = ttNumerico
      end
      object edtNomCli: TEditFocus
        Left = 125
        Top = 36
        Width = 432
        Height = 22
        TabStop = False
        Alignment = taLeftJustify
        Color = 16768952
        Enabled = False
        ImeName = 'Portugu'#234's (Brasil ABNT)'
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
  end
  inherited pnlStatus: TPanel
    Top = 412
    Width = 673
    TabOrder = 2
    ExplicitTop = 412
    ExplicitWidth = 673
    inherited pnlNomeForm: TPanel
      Left = 502
      TabOrder = 1
      ExplicitLeft = 502
    end
    inherited pnlInfo: TPanel
      Width = 502
      TabOrder = 0
      ExplicitWidth = 502
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 972
    Top = 110
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 944
    Top = 106
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 224
    Top = 24
  end
  object dtsPedidos: TDataSource
    Left = 630
    Top = 150
  end
end
