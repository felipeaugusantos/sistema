inherited frmBaixaCtaReceber: TfrmBaixaCtaReceber
  Left = 150
  Top = 131
  Width = 800
  Height = 572
  ActiveControl = nil
  BorderIcons = [biSystemMenu]
  Caption = 'Baixa de Contas a Receber'
  KeyPreview = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  ExplicitWidth = 800
  ExplicitHeight = 572
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 493
    Width = 794
    TabOrder = 5
    ExplicitTop = 493
    ExplicitWidth = 794
    inherited btnSair: TBitBtn
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 524
    Width = 794
    TabOrder = 4
    ExplicitTop = 524
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 623
      ExplicitLeft = 623
    end
    inherited pnlInfo: TPanel
      Width = 623
      ExplicitWidth = 623
    end
  end
  inherited pgcDados: TPageControl
    Top = 129
    Width = 794
    Height = 364
    ActivePage = nil
    TabOrder = 1
    TabStop = False
    Visible = False
    ExplicitTop = 129
    ExplicitWidth = 794
    ExplicitHeight = 364
    inherited tbsGeral: TTabSheet
      TabVisible = False
      ExplicitLeft = 4
      ExplicitTop = 6
      ExplicitWidth = 786
      ExplicitHeight = 354
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 129
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 0
    object Label1: TLabel
      Left = 81
      Top = 12
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object Label2: TLabel
      Left = 13
      Top = 104
      Width = 102
      Height = 14
      Alignment = taRightJustify
      Caption = 'Per'#237'odo  Vencimento:'
    end
    object Label3: TLabel
      Left = 195
      Top = 104
      Width = 6
      Height = 14
      Alignment = taRightJustify
      Caption = #224
    end
    object Label4: TLabel
      Left = 331
      Top = 104
      Width = 74
      Height = 14
      Alignment = taRightJustify
      Caption = 'Nosso N'#250'mero:'
    end
    object Label8: TLabel
      Left = 80
      Top = 35
      Width = 36
      Height = 14
      Caption = 'Evento:'
    end
    object Label20: TLabel
      Left = 71
      Top = 58
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label5: TLabel
      Left = 71
      Top = 81
      Width = 44
      Height = 14
      Caption = 'Portador:'
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 119
      Top = 8
      Width = 72
      Height = 22
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
      Alignment = taLeftJustify
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 119
      Top = 100
      Width = 72
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 4
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object mskDtaFin: TMaskEditFocus
      Tag = 99
      Left = 206
      Top = 100
      Width = 71
      Height = 22
      EditMask = '99/99/9999'
      MaxLength = 10
      TabOrder = 5
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtNosNum: TEditFocus
      Tag = 99
      Left = 409
      Top = 100
      Width = 72
      Height = 22
      TabOrder = 6
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtNomCli: TEditFocus
      Left = 192
      Top = 8
      Width = 289
      Height = 22
      TabStop = False
      Color = 16768952
      ReadOnly = True
      TabOrder = 7
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtCodEve: TEditFocus
      Tag = 99
      Left = 119
      Top = 31
      Width = 72
      Height = 22
      MaxLength = 5
      TabOrder = 1
      OnKeyPress = edtCodEveKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtDesEve: TEditFocus
      Left = 192
      Top = 31
      Width = 289
      Height = 22
      TabStop = False
      Color = 16768952
      TabOrder = 8
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtNomEmp: TEditFocus
      Left = 192
      Top = 54
      Width = 289
      Height = 22
      TabStop = False
      Color = 16768952
      ReadOnly = True
      TabOrder = 9
      NormalColor = 16768952
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
      Left = 119
      Top = 54
      Width = 72
      Height = 22
      MaxLength = 3
      TabOrder = 2
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
    object edtDesPortador: TEditFocus
      Left = 192
      Top = 77
      Width = 289
      Height = 22
      TabStop = False
      Color = 16768952
      ReadOnly = True
      TabOrder = 10
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtCodPortador: TEditFocus
      Tag = 99
      Left = 119
      Top = 77
      Width = 72
      Height = 22
      MaxLength = 5
      TabOrder = 3
      OnKeyPress = edtCodPortadorKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 5
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
  end
  object pnlAux2: TPanel [4]
    Left = 0
    Top = 129
    Width = 794
    Height = 364
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlTotais: TPanel
      Left = 0
      Top = 218
      Width = 794
      Height = 146
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      TabOrder = 1
      object Label21: TLabel
        Left = 231
        Top = 10
        Width = 26
        Height = 14
        Alignment = taRightJustify
        Caption = 'Total:'
      end
      object Label23: TLabel
        Left = 199
        Top = 33
        Width = 58
        Height = 14
        Alignment = taRightJustify
        Caption = 'Recebendo:'
      end
      object Label6: TLabel
        Left = 22
        Top = 10
        Width = 76
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Duplicatas:'
      end
      object Label9: TLabel
        Left = 7
        Top = 33
        Width = 91
        Height = 14
        Alignment = taRightJustify
        Caption = 'Qtd. Selecionadas:'
      end
      object Label7: TLabel
        Left = 54
        Top = 56
        Width = 44
        Height = 14
        Alignment = taRightJustify
        Caption = 'Portador:'
      end
      object Label10: TLabel
        Left = 68
        Top = 79
        Width = 30
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nome:'
      end
      object Label12: TLabel
        Left = 343
        Top = 56
        Width = 54
        Height = 14
        Alignment = taRightJustify
        Caption = 'Nosso Nro:'
      end
      object Label11: TLabel
        Left = 361
        Top = 10
        Width = 36
        Height = 14
        Caption = 'Evento:'
      end
      object Label13: TLabel
        Left = 345
        Top = 33
        Width = 52
        Height = 14
        Caption = 'Descri'#231#227'o:'
      end
      object Label14: TLabel
        Left = 352
        Top = 79
        Width = 45
        Height = 14
        Alignment = taRightJustify
        Caption = 'Hist'#243'rico:'
      end
      object Label15: TLabel
        Left = 349
        Top = 124
        Width = 48
        Height = 14
        Alignment = taRightJustify
        Caption = 'Doc. Ant.:'
      end
      object lblDespCob: TLabel
        Left = 17
        Top = 102
        Width = 81
        Height = 14
        Alignment = taRightJustify
        Caption = 'Desp. Cobran'#231'a:'
        Visible = False
      end
      object edtQtdDuplicatas: TEditFocus
        Left = 101
        Top = 6
        Width = 80
        Height = 22
        TabStop = False
        Color = 16768952
        ReadOnly = True
        TabOrder = 0
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taRightJustify
      end
      object edtQtdSelecionadas: TEditFocus
        Left = 101
        Top = 29
        Width = 80
        Height = 22
        TabStop = False
        Color = 16768952
        ReadOnly = True
        TabOrder = 1
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taRightJustify
      end
      object edtValorTotal: TEditFocus
        Left = 260
        Top = 6
        Width = 80
        Height = 22
        TabStop = False
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
        Alignment = taRightJustify
      end
      object edtTotalRecebido: TEditFocus
        Left = 260
        Top = 29
        Width = 80
        Height = 22
        TabStop = False
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
        Alignment = taRightJustify
      end
      object edtCodPorBai: TEditFocus
        Left = 101
        Top = 52
        Width = 239
        Height = 22
        TabStop = False
        Color = 16768952
        ReadOnly = True
        TabOrder = 4
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object edtNomPorBai: TEditFocus
        Left = 101
        Top = 75
        Width = 239
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
      object edtNosNumBai: TEditFocus
        Left = 399
        Top = 52
        Width = 239
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
      object edtCodEveBai: TEditFocus
        Left = 399
        Top = 6
        Width = 239
        Height = 22
        TabStop = False
        Color = 16768952
        TabOrder = 7
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object edtDesEveBai: TEditFocus
        Left = 399
        Top = 29
        Width = 239
        Height = 22
        TabStop = False
        Color = 16768952
        TabOrder = 8
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object edtCodVel: TEditFocus
        Left = 399
        Top = 120
        Width = 239
        Height = 22
        TabStop = False
        Color = 16768952
        ReadOnly = True
        TabOrder = 9
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taLeftJustify
      end
      object pnlInformativos: TPanel
        Left = 647
        Top = 2
        Width = 145
        Height = 142
        Align = alRight
        BevelInner = bvRaised
        BevelOuter = bvLowered
        Color = 16770261
        TabOrder = 10
        object Label16: TLabel
          Left = 2
          Top = 2
          Width = 141
          Height = 12
          Align = alTop
          Alignment = taCenter
          AutoSize = False
          Caption = 'INFORMATIVO'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = 14
          Font.Name = 'Arial'
          Font.Pitch = fpVariable
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Left = 32
          Top = 54
          Width = 30
          Height = 14
          Alignment = taRightJustify
          Caption = 'Juros:'
        end
        object Label19: TLabel
          Left = 13
          Top = 77
          Width = 49
          Height = 14
          Alignment = taRightJustify
          Caption = 'Desconto:'
        end
        object edtJurosTotal: TEditFocus
          Left = 66
          Top = 50
          Width = 60
          Height = 22
          TabStop = False
          Color = 16768952
          ReadOnly = True
          TabOrder = 0
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          Alignment = taRightJustify
        end
        object edtDescontoTotal: TEditFocus
          Left = 66
          Top = 73
          Width = 60
          Height = 22
          TabStop = False
          Color = 16768952
          ReadOnly = True
          TabOrder = 1
          NormalColor = 16768952
          FocusColor = clInfoBk
          RequeridoColor = clRed
          Requerido = False
          CompZeros = False
          TamCampo = 0
          TipoTexto = ttAlfanumerico
          Alignment = taRightJustify
        end
      end
      object edtHistor: TMemoFocus
        Left = 399
        Top = 75
        Width = 239
        Height = 44
        TabStop = False
        Color = 16768952
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 11
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        StringQuebra = '<<csq>>'
      end
      object edtDespCob: TEditFocus
        Left = 101
        Top = 98
        Width = 80
        Height = 22
        TabStop = False
        Color = 16768952
        ReadOnly = True
        TabOrder = 12
        Visible = False
        NormalColor = 16768952
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        CompZeros = False
        TamCampo = 0
        TipoTexto = ttAlfanumerico
        Alignment = taRightJustify
      end
    end
    object dbgDuplicatas: TDBGridCitel
      Left = 0
      Top = 0
      Width = 794
      Height = 218
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDuplicatasDrawColumnCell
      OnDblClick = dbgDuplicatasDblClick
      OnKeyDown = dbgDuplicatasKeyDown
      Columns = <
        item
          Expanded = False
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'CTR_NUMDUP'
          Title.Caption = 'Duplicata'
          Width = 95
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_ESPDOC'
          Title.Caption = 'Esp'#233'cie'
          Width = 51
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_NOMCLI'
          Title.Caption = 'Cliente'
          Width = 286
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_CODEMP'
          Title.Caption = 'Empresa'
          Width = 45
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_DTACAD'
          Title.Caption = 'Cadastro'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_DTAVEN'
          Title.Caption = 'Vencimento'
          Width = 65
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CTR_VALSUJ'
          Title.Caption = 'Vr. Original'
          Width = 65
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CTR_VALCAL'
          Title.Alignment = taRightJustify
          Title.Caption = 'Vr. Corrigido'
          Width = 85
          Visible = True
        end>
    end
  end
  object pnlBotoesBaixa: TPanel [5]
    Left = 0
    Top = 493
    Width = 794
    Height = 31
    Align = alBottom
    BevelInner = bvLowered
    Color = 16770261
    TabOrder = 3
    object btnIniBus: TBitBtn
      Left = 213
      Top = 5
      Width = 92
      Height = 22
      Caption = '[ F5 ] inicia Busca'
      TabOrder = 2
      OnClick = btnIniBusClick
    end
    object btnLocProx: TBitBtn
      Left = 305
      Top = 5
      Width = 116
      Height = 22
      Caption = '[ F6 ] Localiza Pr'#243'xima'
      TabOrder = 3
      OnClick = btnLocProxClick
    end
    object btnConfirma: TBitBtn
      Left = 630
      Top = 5
      Width = 89
      Height = 22
      Caption = '[ F10 ] Confirma'
      TabOrder = 6
      OnClick = btnConfirmaClick
    end
    object btnSairBaixa: TBitBtn
      Left = 720
      Top = 5
      Width = 67
      Height = 22
      Caption = '[ Esc ] Sair'
      TabOrder = 7
      OnClick = btnSairBaixaClick
    end
    object btnRecalculaJuros: TBitBtn
      Left = 421
      Top = 5
      Width = 111
      Height = 22
      Caption = '[ F8 ] Recalcula Juros'
      TabOrder = 4
      OnClick = btnRecalculaJurosClick
    end
    object BtnSelecionadas: TBitBtn
      Left = 532
      Top = 5
      Width = 98
      Height = 22
      Caption = '[ F9 ] Selecionadas'
      TabOrder = 5
      OnClick = BtnSelecionadasClick
    end
    object btnMarcarTodas: TBitBtn
      Left = 2
      Top = 5
      Width = 96
      Height = 22
      Caption = '[ F3 ] Marcar todas'
      TabOrder = 0
      OnClick = btnMarcarTodasClick
    end
    object btnDesmarcarTodas: TBitBtn
      Left = 98
      Top = 5
      Width = 115
      Height = 22
      Caption = '[ F4 ] Desmarcar todas'
      TabOrder = 1
      OnClick = btnMarcarTodasClick
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 296
    Top = 16
  end
end
