inherited frmEstornoCtaPagar: TfrmEstornoCtaPagar
  Left = 176
  Top = 146
  Width = 800
  Height = 557
  BorderIcons = [biSystemMenu]
  Caption = 'Estorno de Contas a Pagar'
  Position = poMainFormCenter
  ExplicitWidth = 800
  ExplicitHeight = 557
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 513
    Width = 794
    ExplicitTop = 513
    ExplicitWidth = 794
    DesignSize = (
      794
      0)
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 513
    Width = 794
    ExplicitTop = 513
    ExplicitWidth = 794
    inherited pnlNomeForm: TPanel
      Left = 626
      Width = 168
      ExplicitLeft = 626
      ExplicitWidth = 168
    end
    inherited pnlInfo: TPanel
      Width = 626
      ExplicitWidth = 626
    end
  end
  inherited pgcDados: TPageControl
    Top = 65
    Width = 794
    Height = 448
    Visible = False
    ExplicitTop = 65
    ExplicitWidth = 794
    ExplicitHeight = 448
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 786
      ExplicitHeight = 416
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 794
    Height = 65
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label1: TLabel
      Left = 27
      Top = 14
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Duplicata:'
    end
    object Label2: TLabel
      Left = 199
      Top = 37
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object Label3: TLabel
      Left = 213
      Top = 14
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label4: TLabel
      Left = 46
      Top = 37
      Width = 28
      Height = 14
      Alignment = taRightJustify
      Caption = 'S'#233'rie:'
    end
    object edtNumDup: TEditFocus
      Tag = 99
      Left = 77
      Top = 10
      Width = 88
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtParcel: TEditFocus
      Tag = 99
      Left = 167
      Top = 10
      Width = 26
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 1
      Text = 'A'
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = -1
      TipoTexto = ttAlfabetico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 261
      Top = 33
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 4
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 261
      Top = 10
      Width = 65
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 2
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttAlfanumerico
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 77
      Top = 33
      Width = 48
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtNomEmp: TEditFocus
      Left = 327
      Top = 10
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
    object edtNomFor: TEditFocus
      Left = 327
      Top = 33
      Width = 402
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 65
    Width = 794
    Height = 448
    Align = alClient
    ParentBackground = False
    TabOrder = 4
    object dbgDuplicatas: TDBGridCitel
      Left = 1
      Top = 1
      Width = 792
      Height = 418
      Align = alClient
      DataSource = dtsDados
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
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
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTP_NUMDUP'
          Title.Alignment = taCenter
          Title.Caption = 'Duplicata'
          Width = 110
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTP_SEQBAI'
          Title.Alignment = taCenter
          Title.Caption = 'Seq'
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTP_CODEMP'
          Title.Alignment = taCenter
          Title.Caption = 'Emp'
          Width = 90
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'CTP_DTAPAG'
          Title.Alignment = taCenter
          Title.Caption = 'Dta. Pag.'
          Width = 110
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CTP_VALPAG'
          Title.Alignment = taCenter
          Title.Caption = 'Val. Pago'
          Width = 120
          Visible = True
        end>
    end
    object pnlBotoesEstorno: TPanel
      Left = 1
      Top = 419
      Width = 792
      Height = 28
      Align = alBottom
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object btnConfirma: TBitBtnLocked
        Left = 5
        Top = 3
        Width = 136
        Height = 21
        Caption = '[ F10 ] Confirma Estorno'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnSairEst: TBitBtnLocked
        Left = 651
        Top = 3
        Width = 136
        Height = 21
        Caption = '[ ESC ] Sair'
        TabOrder = 1
        OnClick = btnSairEstClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 360
    Top = 224
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 328
    Top = 224
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 208
    Top = 208
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 392
    Top = 224
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'PARDUP;CTP_SEQBAI'
    Params = <>
    ProviderName = 'cpvDados'
    Left = 424
    Top = 224
  end
  object cpvDados: TUniDataSetProvider
    DataSet = qryDados
    Options = []
    Left = 456
    Top = 224
  end
  object qryDados: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Left = 488
    Top = 224
  end
end
