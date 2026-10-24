inherited frmChqHistorico: TfrmChqHistorico
  Left = 65
  Top = 166
  Width = 800
  Height = 462
  ActiveControl = edtCodEmp
  Caption = 'Altera'#231#227'o do Hist'#243'rico dos Cheques'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 391
    Width = 792
    inherited btnSair: TBitBtn
      Left = 711
      Caption = 'Sair'
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
    inherited btnMudaOrdem: TBitBtn
      Left = 5
    end
    inherited btnPesquisar: TBitBtn
      Left = 124
    end
  end
  inherited pnlStatus: TPanel
    Top = 419
    Width = 792
    inherited pnlNomeForm: TPanel
      Left = 621
    end
    inherited pnlInfo: TPanel
      Width = 621
    end
  end
  inherited pnlHeader: TPanel
    Width = 792
    Height = 99
    object Label1: TLabel
      Left = 90
      Top = 37
      Width = 34
      Height = 14
      Alignment = taRightJustify
      Caption = 'Banco:'
    end
    object Label2: TLabel
      Left = 81
      Top = 59
      Width = 43
      Height = 14
      Alignment = taRightJustify
      Caption = 'Ag'#234'ncia:'
    end
    object Label3: TLabel
      Left = 241
      Top = 59
      Width = 67
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cta. Corrente:'
    end
    object Label4: TLabel
      Left = 459
      Top = 59
      Width = 78
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nro. do Cheque:'
    end
    object Label27: TLabel
      Left = 79
      Top = 14
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label5: TLabel
      Left = 10
      Top = 81
      Width = 114
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo de Vencimento:'
    end
    object Label6: TLabel
      Left = 202
      Top = 81
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object edtCodBco: TEditFocus
      Tag = 99
      Left = 126
      Top = 30
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 1
      OnKeyPress = edtCodBcoKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtNumAge: TEditFocus
      Tag = 99
      Left = 126
      Top = 52
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtConCor: TEditFocus
      Tag = 99
      Left = 310
      Top = 52
      Width = 88
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtNumChq: TEditFocus
      Tag = 99
      Left = 539
      Top = 52
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 126
      Top = 7
      Width = 43
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      MaxLength = 3
      ParentFont = False
      TabOrder = 0
      OnEnter = edtCodEmpEnter
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtNomEmp: TEditFocus
      Left = 170
      Top = 7
      Width = 461
      Height = 22
      TabStop = False
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
      Alignment = taLeftJustify
    end
    object edtNomBan: TEditFocus
      Left = 170
      Top = 30
      Width = 461
      Height = 22
      TabStop = False
      Color = 16768952
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 126
      Top = 74
      Width = 70
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 7
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 214
      Top = 74
      Width = 71
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
  end
  inherited pnlTail: TPanel
    Top = 363
    Width = 792
    Height = 28
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 139
    Width = 792
    Height = 224
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    OnKeyDown = dbgConsultaKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'CHQ_DTAVEN'
        ReadOnly = True
        Title.Caption = 'Vencimento'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHQ_NUMCHQ'
        ReadOnly = True
        Title.Caption = 'Nro. Cheque'
        Width = 70
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHQ_VALCHQ'
        ReadOnly = True
        Title.Caption = 'Valor'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHQ_HIST01'
        Title.Caption = 'Hist'#243'rico 1'
        Width = 208
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHQ_HIST02'
        Title.Caption = 'Hist'#243'rico 2'
        Width = 239
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BCO_NOMBCO'
        ReadOnly = True
        Title.Caption = 'Nome do Banco'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CHQ_CODCLI'
        ReadOnly = True
        Title.Caption = 'C'#243'd.Cliente'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLI_NOMCLI'
        ReadOnly = True
        Title.Caption = 'Nome do Cliente'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHQ_NOMEMI'
        ReadOnly = True
        Title.Caption = 'Emitente'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHQ_DTACAD'
        ReadOnly = True
        Title.Caption = 'Cadastro'
        Width = 65
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHQ_CODBCO'
        ReadOnly = True
        Title.Caption = 'Banco'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHQ_C_G_C_'
        ReadOnly = True
        Title.Caption = 'CNPJ'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CHQ_NUMAGE'
        ReadOnly = True
        Title.Caption = 'Ag'#234'ncia'
        Width = 45
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CHQ_CONCOR'
        ReadOnly = True
        Title.Caption = 'Conta Corrente'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOMETABELA'
        ReadOnly = True
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'CHQ_CODEMP'
        ReadOnly = True
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'AUTOINCREM'
        ReadOnly = True
        Visible = False
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 99
    Width = 792
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 1080
    Top = 376
  end
  inherited qryConsulta: TUniQuery
    Left = 472
    Top = 240
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 536
    Top = 240
  end
  inherited cdsConsulta: TUniClientDataSet
    BeforeClose = cdsConsultaBeforeClose
    AfterEdit = cdsConsultaAfterEdit
    AfterPost = cdsConsultaAfterPost
    Left = 568
    Top = 240
  end
  inherited dtsConsulta: TDataSource
    Left = 600
    Top = 240
  end
end
