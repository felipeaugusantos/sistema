inherited frmFatDadosFiscaisImpIcmsDes: TfrmFatDadosFiscaisImpIcmsDes
  Width = 855
  Height = 598
  Caption = 'Dados Fiscais Itens - ICMS Desonerado'
  ExplicitWidth = 855
  ExplicitHeight = 598
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 527
    Width = 849
    ExplicitTop = 527
    ExplicitWidth = 849
    inherited FlwBotoes: TFlowPanel
      Width = 692
      ExplicitWidth = 845
      ExplicitHeight = 25
      inherited btnConfirma: TBitBtnLocked
        Width = 157
        Caption = '[ F10 ] &Confirma'
        ModalResult = 0
        ExplicitWidth = 157
      end
      object btnDistIcmDes: TBitBtnLocked
        Left = 157
        Top = 0
        Width = 200
        Height = 22
        Caption = '[ F3 ] &Distribuir Icms Desonerado'
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
        TabOrder = 1
        OnClick = btnDistIcmDesClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 694
      Top = 2
      Width = 153
      Align = alRight
      Caption = '[ ESC ] &Cancelar'
      ExplicitLeft = 693
      ExplicitWidth = 153
    end
  end
  object dbgItens: TDBGridCitel [2]
    Left = 0
    Top = 0
    Width = 849
    Height = 415
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
    OnColExit = dbgItensColExit
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
        Width = 145
        Visible = True
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
        FieldName = 'ITE_DESONE'
        PickList.Strings = (
          'Sim'
          'N'#227'o')
        Title.Caption = 'ICMS Desonerado?'
        Width = 98
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_VRDICM'
        Title.Alignment = taRightJustify
        Title.Caption = 'Vr.Icms Desonerado'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ITE_MTDICM'
        Title.Caption = 'Motivo Desonera'#231#227'o'
        Width = 337
        Visible = True
      end>
  end
  object pnlResImp: TPanel [3]
    Left = 0
    Top = 434
    Width = 849
    Height = 37
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    ExplicitTop = 431
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
    Top = 490
    Width = 849
    Height = 37
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 4
    ExplicitTop = 487
    object Label16: TLabel
      Left = 7
      Top = 13
      Width = 89
      Height = 14
      Alignment = taRightJustify
      Caption = 'ICMS Desonerado:'
    end
    object edtVrdIcm: TEditFocus
      Tag = 99
      Left = 98
      Top = 6
      Width = 70
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
  end
  object Panel2: TPanel [5]
    Left = 0
    Top = 471
    Width = 849
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
    ExplicitTop = 468
  end
  object Panel3: TPanel [6]
    Left = 0
    Top = 415
    Width = 849
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
    ExplicitTop = 412
  end
  inherited pnlStatus: TPanel
    Top = 553
    Width = 849
    ExplicitTop = 553
    ExplicitWidth = 849
    inherited pnlNomeForm: TPanel
      Left = 678
      ExplicitLeft = 678
    end
    inherited pnlInfo: TPanel
      Width = 678
      ExplicitWidth = 678
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
      OnChange = cdsItensITE_DESONEChange
      Size = 3
    end
    object cdsItensITE_BASVRD: TFloatField
      FieldName = 'ITE_BASVRD'
    end
    object cdsItensITE_SITANT: TStringField
      FieldName = 'ITE_SITANT'
      Size = 3
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
