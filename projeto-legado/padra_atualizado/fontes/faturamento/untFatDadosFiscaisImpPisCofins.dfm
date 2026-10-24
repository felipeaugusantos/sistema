inherited frmFatDadosFiscaisImpPisCofins: TfrmFatDadosFiscaisImpPisCofins
  Width = 814
  Height = 598
  Caption = 'Dados Fiscais Itens - Pis / Cofins'
  ExplicitWidth = 814
  ExplicitHeight = 598
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 503
    Width = 808
    Height = 50
    ExplicitTop = 503
    ExplicitWidth = 808
    ExplicitHeight = 50
    DesignSize = (
      808
      50)
    inherited FlwBotoes: TFlowPanel
      Width = 804
      Height = 46
      ExplicitWidth = 804
      ExplicitHeight = 46
      inherited btnConfirma: TBitBtnLocked
        Width = 160
        Caption = '[ F10 ] &Confirma'
        ExplicitWidth = 160
      end
      object btnZerarPis: TBitBtnLocked
        Left = 160
        Top = 0
        Width = 165
        Height = 22
        Caption = '[ F2 ] Zerar Pis'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 1
        OnClick = btnZerarPisClick
      end
      object btnZerarCof: TBitBtnLocked
        Left = 325
        Top = 0
        Width = 165
        Height = 22
        Caption = '[ F3 ] Zerar Cofins'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
          555555555555555555555555555555555555555555FF55555555555559055555
          55555555577FF5555555555599905555555555557777F5555555555599905555
          555555557777FF5555555559999905555555555777777F555555559999990555
          5555557777777FF5555557990599905555555777757777F55555790555599055
          55557775555777FF5555555555599905555555555557777F5555555555559905
          555555555555777FF5555555555559905555555555555777FF55555555555579
          05555555555555777FF5555555555557905555555555555777FF555555555555
          5990555555555555577755555555555555555555555555555555}
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnZerarCofClick
      end
      object btnInfPis: TBitBtnLocked
        Left = 490
        Top = 0
        Width = 165
        Height = 22
        Caption = '[ F5 ] &Distribuir Pis'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
          CCCCCC6060400000FF0000FF0000C000007C606050CCCCCCC0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CCCCCC6060400000FF0000FF0000C000
          007C606050CCCCCCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          CCCCCC5A5A3A0000FF0000FF0000CC000086545444CCCCCCC0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C69A9A9A2626068B8B6B5E5E461A
          1A0ADEDEDEC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          CCCCCC7E7E7EC5C5C5FFFFFFF9F9F9282828DADADAC0C0C0CCBCBCC6BEBEC0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C6828282BBBBBBFFFFFFFFFFFFFFFFFFB6
          B6B6404040D8C8C83CEBEB94CCCCCCBCBCC0C0C0C0C0C0C0C0C0C0C0C0CACACA
          4E4E4EFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF2A2A2ADAD2D2A0C8C81CFFFFA0C8
          C8D8B8B8C0C0C0C0C0C0C0C0C0D4D4D45A5A5AFFFFFFDBDBDBFFFFFFFFFFFFFF
          FFFF5454549A8A8A4CEBEB86EDED00FFFF18F7F7E4B4B4C0C0C0CCCCCC303030
          FFFFFFFFFFFF787878FFFFFFFFFFFFFFFFFFCECECE484040A6D6D674F3F346FF
          FF00FFFF18F7F7D2CACAD4D4D48080807070704C4C4CF5F5F5FFFFFFFFFFFFFF
          FFFFC4C4C45444445AF1F164DBDB7CD3D300FFFF00FFFFDB0C0C4848484A4A4A
          949494787878CBCBCBFFFFFFC3C3C3383838D8D8D854444460EFEF22F1F100FF
          FF00FFFF00FFFFAC9C9CCCCCCCCCCCCCCECECE808080181818D0D0D078787824
          2424DCDCDC4E4646A6D6D680EFEF4CFFFF00FFFFA8C8C8CAC2C2C0C0C0C0C0C0
          C8C8C8808080282828D8D8D8808080282828E8E8E848383858EFEF32FFFF0EF5
          F5A2CACACCBCBCC0C0C0C0C0C0C0C0C0C8C8C88282822C2C2CD8D8D888888832
          3232404040DED6D69ACACA5EFDFDDCB4B4C6BEBEC0C0C0C0C0C0C0C0C0C0C0C0
          CACACA646464000000F0F0F0161616383838DADADACCBCBC36EDEDD6B6B6C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CACACAE0E0E03C3C3CDCDCDCCE
          CECEC0C0C0C0C0C0CCBCBCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
        TabOrder = 3
        OnClick = btnInfPisClick
      end
      object btnInfCof: TBitBtnLocked
        Left = 0
        Top = 22
        Width = 160
        Height = 22
        Caption = '[ F6 ] Distribuir Cofins'
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          18000000000000030000C40E0000C40E00000000000000000000C0C0C0C0C0C0
          CCCCCC6060400000FF0000FF0000C000007C606050CCCCCCC0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CCCCCC6060400000FF0000FF0000C000
          007C606050CCCCCCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          CCCCCC5A5A3A0000FF0000FF0000CC000086545444CCCCCCC0C0C0C0C0C0C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C69A9A9A2626068B8B6B5E5E461A
          1A0ADEDEDEC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
          CCCCCC7E7E7EC5C5C5FFFFFFF9F9F9282828DADADAC0C0C0CCBCBCC6BEBEC0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C6C6C6828282BBBBBBFFFFFFFFFFFFFFFFFFB6
          B6B6404040D8C8C83CEBEB94CCCCCCBCBCC0C0C0C0C0C0C0C0C0C0C0C0CACACA
          4E4E4EFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF2A2A2ADAD2D2A0C8C81CFFFFA0C8
          C8D8B8B8C0C0C0C0C0C0C0C0C0D4D4D45A5A5AFFFFFFDBDBDBFFFFFFFFFFFFFF
          FFFF5454549A8A8A4CEBEB86EDED00FFFF18F7F7E4B4B4C0C0C0CCCCCC303030
          FFFFFFFFFFFF787878FFFFFFFFFFFFFFFFFFCECECE484040A6D6D674F3F346FF
          FF00FFFF18F7F7D2CACAD4D4D48080807070704C4C4CF5F5F5FFFFFFFFFFFFFF
          FFFFC4C4C45444445AF1F164DBDB7CD3D300FFFF00FFFFDB0C0C4848484A4A4A
          949494787878CBCBCBFFFFFFC3C3C3383838D8D8D854444460EFEF22F1F100FF
          FF00FFFF00FFFFAC9C9CCCCCCCCCCCCCCECECE808080181818D0D0D078787824
          2424DCDCDC4E4646A6D6D680EFEF4CFFFF00FFFFA8C8C8CAC2C2C0C0C0C0C0C0
          C8C8C8808080282828D8D8D8808080282828E8E8E848383858EFEF32FFFF0EF5
          F5A2CACACCBCBCC0C0C0C0C0C0C0C0C0C8C8C88282822C2C2CD8D8D888888832
          3232404040DED6D69ACACA5EFDFDDCB4B4C6BEBEC0C0C0C0C0C0C0C0C0C0C0C0
          CACACA646464000000F0F0F0161616383838DADADACCBCBC36EDEDD6B6B6C0C0
          C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CACACAE0E0E03C3C3CDCDCDCCE
          CECEC0C0C0C0C0C0CCBCBCC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0}
        TabOrder = 4
        OnClick = btnInfCofClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 655
      Top = 24
      Width = 150
      Caption = '[ ESC ] &Cancelar'
      ExplicitLeft = 655
      ExplicitTop = 24
      ExplicitWidth = 150
    end
  end
  object dbgItens: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 808
    Height = 391
    Align = alClient
    DataSource = dtsItens
    ImeName = 'Portugu'#234's (Brasil ABNT)'
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = 14
    TitleFont.Name = 'Arial'
    TitleFont.Pitch = fpVariable
    TitleFont.Style = []
    OnDrawColumnCell = dbgItensDrawColumnCell
    OnKeyDown = dbgItensKeyDown
    OnKeyPress = dbgItensKeyPress
    CorZebra = clMoneyGreen
    Zebra = False
    DestacarMouse = False
    Columns = <
      item
        Expanded = False
        FieldName = 'AUTOINCREM'
        ReadOnly = True
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ITE_CODITE'
        ReadOnly = True
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_DESITE'
        ReadOnly = True
        Width = 198
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_REFERE'
        ReadOnly = True
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ITE_SIGUNI'
        ReadOnly = True
        Title.Alignment = taCenter
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'ITE_TOTITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CSTPIS'
        Title.Caption = 'CST.Pis'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_BASPIS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Base Pis'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_ALQPIS'
        Title.Alignment = taRightJustify
        Title.Caption = 'Alq.Pis'
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_VALPIS'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Pis'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_CSTCOF'
        Title.Caption = 'CST.Cofins'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_BASCOF'
        Title.Alignment = taRightJustify
        Title.Caption = 'Base Cofins'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_ALQCOF'
        Title.Alignment = taRightJustify
        Title.Caption = 'Alq.Cofins'
        Width = 67
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_VALCOF'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Cofins'
        Width = 70
        Visible = True
      end>
  end
  object pnlResImp: TPanel [3]
    Left = 0
    Top = 410
    Width = 808
    Height = 37
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label12: TLabel
      Left = 7
      Top = 12
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object Label9: TLabel
      Left = 433
      Top = 12
      Width = 56
      Height = 14
      Alignment = taRightJustify
      Caption = 'Refer'#234'ncia:'
    end
    object Label10: TLabel
      Left = 680
      Top = 12
      Width = 17
      Height = 14
      Alignment = taRightJustify
      Caption = 'UN:'
    end
    object DBEditFocus1: TDBEditFocus
      Left = 61
      Top = 6
      Width = 366
      Height = 22
      DataField = 'ITE_DESITE'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus2: TDBEditFocus
      Left = 492
      Top = 6
      Width = 170
      Height = 22
      DataField = 'ITE_REFERE'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object DBEditFocus3: TDBEditFocus
      Left = 699
      Top = 6
      Width = 70
      Height = 22
      DataField = 'ITE_SIGUNI'
      DataSource = dtsItens
      ReadOnly = True
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 466
    Width = 808
    Height = 37
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    object Label1: TLabel
      Left = 14
      Top = 13
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base Pis:'
    end
    object Label13: TLabel
      Left = 254
      Top = 13
      Width = 62
      Height = 14
      Alignment = taRightJustify
      Caption = 'Base Cofins:'
    end
    object Label15: TLabel
      Left = 148
      Top = 13
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object Label16: TLabel
      Left = 405
      Top = 13
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'Valor:'
    end
    object edtBasPis: TEditFocus
      Tag = 99
      Left = 61
      Top = 6
      Width = 80
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 0
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtBasCof: TEditFocus
      Tag = 99
      Left = 318
      Top = 6
      Width = 80
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 1
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValPis: TEditFocus
      Tag = 99
      Left = 178
      Top = 6
      Width = 70
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 2
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
    object edtValCof: TEditFocus
      Tag = 99
      Left = 435
      Top = 6
      Width = 70
      Height = 22
      Alignment = taRightJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 3
      Text = '0,00'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      EditFormat = '#,##0.00'
    end
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 447
    Width = 808
    Height = 19
    Align = alBottom
    Caption = 'TOTAIS DOS PRODUTOS'
    Color = 16770261
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 5
  end
  object Panel3: TPanel [6]
    Left = 0
    Top = 391
    Width = 808
    Height = 19
    Align = alBottom
    Caption = 'INFORMA'#199#213'ES DO PRODUTO'
    Color = 16770261
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 6
  end
  inherited pnlStatus: TPanel
    Top = 553
    Width = 808
    ExplicitTop = 553
    ExplicitWidth = 808
    inherited pnlNomeForm: TPanel
      Left = 637
      ExplicitLeft = 637
    end
    inherited pnlInfo: TPanel
      Width = 637
      ExplicitWidth = 637
    end
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
    Top = 80
  end
  object cdsItens: TUniClientDataSet
    Aggregates = <
      item
        Active = True
        AggregateName = 'AGG_TOTITE'
        Expression = 'SUM(ITE_TOTITE)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_BASICM'
        Expression = 'SUM(ITE_BASICM)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_VALICM'
        Expression = 'SUM(ITE_VALICM)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_BASIPI'
        Expression = 'SUM(ITE_BASIPI)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_VALIPI'
        Expression = 'SUM(ITE_VALIPI)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_BASRET'
        Expression = 'SUM(ITE_BASRET)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_VALRET'
        Expression = 'SUM(ITE_VALRET)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_BASPIS'
        Expression = 'SUM(ITE_BASPIS)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_VALPIS'
        Expression = 'SUM(ITE_VALPIS)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_BASCOF'
        Expression = 'SUM(ITE_BASCOF)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_VALCOF'
        Expression = 'SUM(ITE_VALCOF)'
        Visible = False
      end
      item
        Active = True
        AggregateName = 'AGG_VRDICM'
        Expression = 'SUM(ITE_VRDICM)'
        Visible = False
      end>
    AggregatesActive = True
    FieldDefs = <>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    BeforeInsert = cdsItensBeforeInsert
    BeforePost = cdsItensBeforePost
    AfterPost = cdsItensAfterPost
    AfterScroll = cdsItensAfterScroll
    Left = 352
    Top = 80
    object cdsItensAUTOINCREM: TIntegerField
      FieldName = 'ITE_AUTINC'
    end
    object cdsItensITE_CODITE: TStringField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'ITE_CODITE'
      Size = 5
    end
    object cdsItensITE_DESITE: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'ITE_DESITE'
      Size = 40
    end
    object cdsItensITE_REFERE: TStringField
      DisplayLabel = 'Refer'#234'ncia'
      FieldName = 'ITE_REFERE'
      Size = 16
    end
    object cdsItensITE_SIGUNI: TStringField
      DisplayLabel = 'UN'
      FieldName = 'ITE_SIGUNI'
      Size = 6
    end
    object cdsItensITE_CODSIT: TStringField
      DisplayLabel = 'Sit.Trib.'
      FieldName = 'ITE_CODSIT'
      Size = 3
    end
    object cdsItensITE_TOTITE: TFloatField
      DisplayLabel = 'Total Item'
      FieldName = 'ITE_TOTITE'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_BASICM: TFloatField
      DisplayLabel = 'Bas.Icms'
      FieldName = 'ITE_BASICM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_ALQICM: TFloatField
      DisplayLabel = 'Alq.Icms'
      FieldName = 'ITE_ALQICM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_VALICM: TFloatField
      DisplayLabel = 'Valor Icms'
      FieldName = 'ITE_VALICM'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_BASIPI: TFloatField
      DisplayLabel = 'Base IPI'
      FieldName = 'ITE_BASIPI'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_ALQIPI: TFloatField
      DisplayLabel = 'Alq. IPI'
      FieldName = 'ITE_ALQIPI'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_VALIPI: TFloatField
      DisplayLabel = 'Valor IPI'
      FieldName = 'ITE_VALIPI'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_BASRET: TFloatField
      DisplayLabel = 'Base Retido'
      FieldName = 'ITE_BASRET'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_VALRET: TFloatField
      DisplayLabel = 'Valor Retido'
      FieldName = 'ITE_VALRET'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_CODABF: TStringField
      FieldName = 'ITE_CODABF'
      Size = 7
    end
    object cdsItensITE_ALQPIS: TFloatField
      FieldName = 'ITE_ALQPIS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_BASPIS: TFloatField
      FieldName = 'ITE_BASPIS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_VALPIS: TFloatField
      FieldName = 'ITE_VALPIS'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_ALQCOF: TFloatField
      FieldName = 'ITE_ALQCOF'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_BASCOF: TFloatField
      FieldName = 'ITE_BASCOF'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_VALCOF: TFloatField
      FieldName = 'ITE_VALCOF'
      DisplayFormat = '#,##0.00'
      EditFormat = '#,##0.00'
    end
    object cdsItensITE_CSTPIS: TStringField
      FieldName = 'ITE_CSTPIS'
      Size = 2
    end
    object cdsItensITE_CSTCOF: TStringField
      FieldName = 'ITE_CSTCOF'
      Size = 2
    end
    object cdsItensITE_CLAFIS: TStringField
      FieldName = 'ITE_CLAFIS'
      Size = 4
    end
    object cdsItensITE_ALTEROU: TBooleanField
      FieldName = 'ITE_ALTEROU'
    end
    object cdsItensITE_VRDICM: TFloatField
      FieldName = 'ITE_VRDICM'
      DisplayFormat = '#,##0.00'
    end
    object cdsItensITE_MTDICM: TStringField
      FieldName = 'ITE_MTDICM'
      Size = 150
    end
    object cdsItensITE_DESONE: TStringField
      FieldName = 'ITE_DESONE'
      Size = 3
    end
    object cdsItensITE_BASVRD: TFloatField
      FieldName = 'ITE_BASVRD'
    end
  end
  object dtsItens: TDataSource
    DataSet = cdsItens
    Left = 384
    Top = 80
  end
  object ColorDialog1: TColorDialog
    Left = 416
    Top = 80
  end
end
