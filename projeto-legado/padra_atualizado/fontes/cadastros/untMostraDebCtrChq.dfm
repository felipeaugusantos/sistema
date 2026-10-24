inherited frmMostraDebCtrChq: TfrmMostraDebCtrChq
  Left = 330
  Top = 183
  Width = 720
  Height = 574
  BorderStyle = bsDialog
  Caption = 'Contas a Receber/Cadastro de Cheques'
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 296
    Width = 712
  end
  inherited pnlStatus: TPanel
    Top = 531
    Width = 712
    inherited pnlNomeForm: TPanel
      Left = 541
    end
    inherited pnlInfo: TPanel
      Width = 541
    end
  end
  inherited pgcDados: TPageControl
    Height = 417
    Align = alNone
  end
  object pnlBotoesMostra: TPanel [3]
    Left = 0
    Top = 502
    Width = 712
    Height = 29
    Align = alBottom
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = clGray
    TabOrder = 3
    DesignSize = (
      712
      29)
    object btnFechar: TBitBtn
      Left = 633
      Top = 4
      Width = 77
      Height = 21
      Anchors = [akRight, akBottom]
      Caption = '&Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000001000000520000006B
        0000006B0800106B0800008C080000940800007B100000731800087B180008A5
        1800089C21001094290010A529001084310010A5310018A5310010A539001884
        4200DE844200218C42002194420018AD420018B5420021B5420021944A00299C
        4A0029BD4A00DE8C52003194520018B5520031C6520031945A00299C5A0031AD
        5A00BD5A6300AD73630029AD630039D66300DEA5840042B59400FFD69C0073A5
        AD00DEBDAD006BA5B5009CBDB500B5C6B500DED6B500FFDEB500D6C6BD00FFE7
        BD00088CC600DECEC60073D6C600E7D6C600EFD6C600F7E7C600FFE7C600088C
        CE000894CE00E7D6CE00109CD600189CD600219CD600299CD60018A5D60021A5
        D60029A5D60031A5D60042ADD600F7E7D600FFE7D600FFEFD60021A5DE0031AD
        DE00E7D6DE00FFEFE700FFF7E7004ACEEF005ADEEF0052CEF7005ADEF70094E7
        F700A5E7F7006BEFF7007BEFF70084F7F7008CF7F7009CF7F700FFFFF700FF00
        FF0063DEFF006BDEFF005AEFFF0073F7FF007BF7FF0084F7FF0094F7FF009CF7
        FF00A5F7FF0073FFFF007BFFFF0084FFFF008CFFFF0094FFFF009CFFFF00A5FF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00593232595959
        5959595959595959595932514E32323232325959595959595959325266655F5F
        5E5A32320203595959593A44685D5E27141819130604085959594144575D651F
        1A1A17150E0905015959424E4465651F1E251A17170E09040059425444696327
        21242432101D0A0D325942562B44606067665D5D0F0B1154415942552A444444
        44446153081F4F5F4D594255305846312E2C445134605B605F3D4255306A4B45
        372F2D444444444444434355336A584B45372F28295C3D5959593F57356A6A58
        4B452323233E3E595959593F366A6A6A6A3B23122259595959595959356A6A6A
        6A4A231B59595959595959592626262626262359595959595959}
    end
  end
  object pnlDebCtr: TPanel [4]
    Left = 0
    Top = 0
    Width = 712
    Height = 296
    Align = alClient
    Color = 16770261
    TabOrder = 4
    object lblDupOri: TLabel
      Left = 186
      Top = 176
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total:'
    end
    object lblJurRec: TLabel
      Left = 331
      Top = 176
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total:'
    end
    object lblCorDif: TLabel
      Left = 475
      Top = 176
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total:'
    end
    object Label1: TLabel
      Left = 9
      Top = 176
      Width = 68
      Height = 14
      Caption = 'Dup. Vencido:'
    end
    object Label2: TLabel
      Left = 4
      Top = 198
      Width = 73
      Height = 14
      Caption = 'Dup. '#224' Vencer:'
    end
    object Label3: TLabel
      Left = 167
      Top = 198
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Hist'#243'rico:'
    end
    object edtDupOri: TEditFocus
      Left = 215
      Top = 169
      Width = 90
      Height = 22
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clWindow
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      Alignment = taRightJustify
    end
    object dbgDuplicatas: TDBGridCitel
      Left = 1
      Top = 25
      Width = 710
      Height = 139
      Align = alTop
      DataSource = dtsTemporaria2
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDuplicatasDrawColumnCell
      OnTitleClick = dbgDuplicatasTitleClick
    end
    object pnlTitCtr: TPanel
      Left = 1
      Top = 1
      Width = 710
      Height = 24
      Align = alTop
      Caption = 'Contas a Receber'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object btnVisChq: TBitBtn
      Left = 250
      Top = 237
      Width = 203
      Height = 25
      Caption = '[ Enter ] Visualizar Cadastro de Cheques'
      Default = True
      TabOrder = 3
      OnClick = btnVisChqClick
    end
    object edtJurRec: TEditFocus
      Left = 360
      Top = 169
      Width = 90
      Height = 22
      ReadOnly = True
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clWindow
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      Alignment = taRightJustify
    end
    object edtCorDif: TEditFocus
      Left = 504
      Top = 169
      Width = 90
      Height = 22
      ReadOnly = True
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clWindow
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      Alignment = taRightJustify
    end
    object edtTotVencido: TEditFocus
      Left = 78
      Top = 169
      Width = 73
      Height = 22
      ReadOnly = True
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taRightJustify
    end
    object edtTotVencer: TEditFocus
      Left = 78
      Top = 193
      Width = 73
      Height = 22
      ReadOnly = True
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taRightJustify
    end
    object dbeHist01: TDBEditFocus
      Left = 215
      Top = 192
      Width = 379
      Height = 22
      TabStop = False
      DataField = 'CTR_HIST01'
      DataSource = dtsTemporaria2
      ReadOnly = True
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeHist02: TDBEditFocus
      Left = 215
      Top = 213
      Width = 379
      Height = 22
      TabStop = False
      DataField = 'CTR_HIST02'
      DataSource = dtsTemporaria2
      ReadOnly = True
      TabOrder = 10
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object btnEnviarEmail: TBitBtn
      Left = 122
      Top = 263
      Width = 127
      Height = 25
      Caption = '[ F9 ] - Enviar email'
      TabOrder = 11
      OnClick = btnEnviarEmailClick
    end
    object btnAgrupamentos: TBitBtn
      Left = 122
      Top = 237
      Width = 127
      Height = 25
      Caption = '[ F8 ] - Dups. Agrupadas'
      Enabled = False
      TabOrder = 12
      OnClick = btnAgrupamentosClick
    end
    object btnProdutos: TBitBtn
      Left = 6
      Top = 237
      Width = 115
      Height = 25
      Caption = '[ F7 ] - Produtos'
      TabOrder = 13
      OnClick = btnProdutosClick
    end
    object btnObsDoc: TBitBtn
      Left = 454
      Top = 237
      Width = 133
      Height = 25
      Caption = '[ F6 ] - Obs. Documento'
      TabOrder = 4
      OnClick = btnObsDocClick
    end
    object btnRelatorio: TBitBtn
      Left = 6
      Top = 263
      Width = 115
      Height = 25
      Caption = '[ F5 ] - Relat'#243'rio'
      TabOrder = 14
      OnClick = btnRelatorioClick
    end
  end
  object pnlDebChq: TPanel [5]
    Left = 0
    Top = 296
    Width = 712
    Height = 206
    Align = alBottom
    Color = 16770261
    TabOrder = 5
    object Label7: TLabel
      Left = 461
      Top = 174
      Width = 26
      Height = 14
      Alignment = taRightJustify
      Caption = 'Total:'
    end
    object edtChqTot: TEditFocus
      Left = 490
      Top = 169
      Width = 103
      Height = 22
      ReadOnly = True
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clWindow
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttNumerico
      Alignment = taRightJustify
    end
    object dbgCheques: TDBGridCitel
      Left = 1
      Top = 25
      Width = 710
      Height = 139
      Align = alTop
      DataSource = dtsTemporaria3
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit]
      ReadOnly = True
      TabOrder = 1
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgChequesDrawColumnCell
      OnTitleClick = dbgChequesTitleClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_NUMCHQ'
          Title.Caption = 'Nro. Cheque'
          Width = 70
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_CODEMP'
          Title.Caption = 'Emp.'
          Width = 40
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_CODBCO'
          Title.Caption = 'Banco'
          Width = 40
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_DTADEP'
          Title.Caption = 'Dt. Dep'#243'sito'
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_DTADEV'
          Title.Caption = 'Dt. Devolu'#231#227'o'
          Width = 80
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CHQ_DTAVEN'
          Title.Caption = 'Dt. Vencimento'
          Width = 80
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CHQ_VALCHQ'
          Title.Alignment = taRightJustify
          Title.Caption = 'Valor'
          Width = 110
          Visible = True
        end>
    end
    object pnlTitChq: TPanel
      Left = 1
      Top = 1
      Width = 710
      Height = 24
      Align = alTop
      Caption = 'Cadastro de Cheques'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
    object btnVisCtr: TBitBtn
      Left = 6
      Top = 170
      Width = 209
      Height = 25
      Caption = '[ Enter ] Visualizar Contas a Receber'
      Default = True
      Enabled = False
      TabOrder = 3
      OnClick = btnVisCtrClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 280
    Top = 192
  end
  object qryTemporaria: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = True
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 520
    Top = 16
  end
  object dtsTemporaria: TDataSource
    DataSet = qryTemporaria
    Left = 608
    Top = 16
  end
  object qryTemporaria2: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = True
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 520
    Top = 64
  end
  object dtsTemporaria2: TDataSource
    DataSet = qryTemporaria2
    Left = 608
    Top = 64
  end
  object qryTemporaria3: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = True
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 520
    Top = 112
  end
  object dtsTemporaria3: TDataSource
    DataSet = qryTemporaria3
    Left = 608
    Top = 112
  end
  object qryProdutosMOVDET: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = False
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 640
    Top = 200
  end
  object qryProdutosNOTDET: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = False
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 640
    Top = 232
  end
  object qryProdutosDUPAGR: TUniQuery
    Connection = frmModulo.Database
    CachedUpdates = False
    RequestLive = False
    ParamCheck = True
    Params = <>
    ShowRecordTypes = [usUnmodified, usModified, usInserted]
    UpdateMode = umUpdateChanged
    WhereMode = wmWhereKeyOnly
    Options = [doCalcDefaults]
    Left = 640
    Top = 168
  end
end
