inherited frmFatBaixaClubeFidelidade: TfrmFatBaixaClubeFidelidade
  Left = 111
  Top = 174
  Width = 565
  Height = 565
  Caption = 'Baixa do Clube de Fidelidade'
  ExplicitWidth = 565
  ExplicitHeight = 565
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 482
    Width = 549
    ExplicitTop = 482
    ExplicitWidth = 521
    inherited FlwBotoes: TFlowPanel
      Width = 545
      ExplicitWidth = 545
      inherited btnMudaOrdem: TBitBtnLocked
        Width = 0
        Visible = False
        ExplicitWidth = 0
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 0
        Width = 0
        Visible = False
        ExplicitLeft = 0
        ExplicitWidth = 0
      end
      object btnConfirma: TBitBtnLocked
        Left = 0
        Top = 0
        Width = 93
        Height = 22
        Caption = '[ F10 ] Confirma'
        NumGlyphs = 2
        TabOrder = 2
        OnClick = btnConfirmaClick
      end
      object btnMarTodos: TBitBtnLocked
        Left = 93
        Top = 0
        Width = 116
        Height = 22
        Caption = '[ F6 ] Marca Todos'
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
        TabOrder = 3
        OnClick = btnMarTodosClick
      end
      object btnDesTodos: TBitBtnLocked
        Left = 209
        Top = 0
        Width = 141
        Height = 22
        Caption = '[ F7 ] Desmarca Todos'
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
          3333333777333777FF3333993333339993333377FF3333377FF3399993333339
          993337777FF3333377F3393999333333993337F777FF333337FF993399933333
          399377F3777FF333377F993339993333399377F33777FF33377F993333999333
          399377F333777FF3377F993333399933399377F3333777FF377F993333339993
          399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
          99333773FF3333777733339993333339933333773FFFFFF77333333999999999
          3333333777333777333333333999993333333333377777333333}
        NumGlyphs = 2
        TabOrder = 4
        OnClick = btnDesTodosClick
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 468
      Caption = 'Sair'
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000120B0000120B0000000100000000000000520000006B
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
      ExplicitLeft = 440
    end
  end
  inherited pnlStatus: TPanel
    Top = 510
    Width = 549
    ExplicitTop = 510
    ExplicitWidth = 521
    inherited pnlNomeForm: TPanel
      Left = 378
      ExplicitLeft = 350
    end
    inherited pnlInfo: TPanel
      Width = 378
      ExplicitWidth = 350
    end
  end
  inherited pnlHeader: TPanel
    Width = 549
    Height = 81
    ExplicitWidth = 521
    ExplicitHeight = 81
    object Label1: TLabel
      Left = 15
      Top = 9
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 11
      Top = 55
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo:'
    end
    object Label3: TLabel
      Left = 131
      Top = 56
      Width = 7
      Height = 12
      Alignment = taRightJustify
      AutoSize = False
      Caption = #224
    end
    object Label4: TLabel
      Left = 5
      Top = 29
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 52
      Top = 5
      Width = 68
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 0
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
      Left = 120
      Top = 5
      Width = 317
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 4
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 52
      Top = 51
      Width = 68
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 2
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 147
      Top = 51
      Width = 69
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 3
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtDesEmpresa: TEditFocus
      Left = 120
      Top = 28
      Width = 317
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 52
      Top = 28
      Width = 68
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 1
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
  end
  inherited pnlTail: TPanel
    Top = 464
    Width = 549
    Height = 18
    Visible = True
    ExplicitLeft = 8
    ExplicitTop = 461
    ExplicitWidth = 549
    ExplicitHeight = 18
    object Label5: TLabel
      Left = 5
      Top = 0
      Width = 200
      Height = 14
      Caption = '[Duplo-Clique] para selecionar documento'
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 121
    Width = 549
    Height = 343
    TabStop = False
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    Columns = <
      item
        Expanded = False
        FieldName = 'FID_CODFID'
        ReadOnly = True
        Title.Caption = 'C'#243'digo'
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DOCUMENTO'
        ReadOnly = True
        Title.Caption = 'Documento'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FID_CREDEB'
        ReadOnly = True
        Title.Caption = 'C/D'
        Width = 26
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FID_DTACAD'
        ReadOnly = True
        Title.Caption = 'Dta Cadastro'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FID_CODEMP'
        ReadOnly = True
        Title.Caption = 'Empresa'
        Width = 80
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'FID_QTDPTO'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd Pontos'
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SIGUNI'
        ReadOnly = True
        Title.Caption = 'Unid.'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'SALDIS'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Saldo Dispon'#237'vel'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd. Pendente'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'UNITAR'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Unit'#225'rio'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'TOTITE'
        ReadOnly = True
        Title.Alignment = taRightJustify
        Title.Caption = 'Valor Total'
        Visible = False
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'QTDBAI'
        Title.Alignment = taRightJustify
        Title.Caption = 'Qtd. a Baixar'
        Visible = False
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 81
    Width = 549
    ExplicitTop = 81
    ExplicitWidth = 521
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 608
    Top = 16
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 664
  end
  inherited qryConsulta: TUniQuery
    Left = 464
    Top = 16
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 496
    Top = 16
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 528
    Top = 16
  end
  inherited dtsConsulta: TDataSource
    Left = 560
    Top = 16
  end
end
