inherited frmEstornoCtaReceber: TfrmEstornoCtaReceber
  Left = 175
  Top = 197
  Width = 656
  Height = 472
  ActiveControl = nil
  BorderIcons = [biSystemMenu]
  Caption = 'Estorno de Contas a Receber'
  KeyPreview = False
  Position = poMainFormCenter
  OnPaint = FormPaint
  ExplicitWidth = 656
  ExplicitHeight = 472
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 431
    Width = 650
    ExplicitTop = 431
    ExplicitWidth = 650
    inherited btnSair: TBitBtnLocked
      Left = 619
      ExplicitLeft = 619
    end
  end
  inherited pnlStatus: TPanel
    Top = 431
    Width = 650
    ExplicitTop = 431
    ExplicitWidth = 650
    inherited pnlNomeForm: TPanel
      Left = 505
      Width = 145
      ExplicitLeft = 505
      ExplicitWidth = 145
    end
    inherited pnlInfo: TPanel
      Width = 505
      ExplicitWidth = 505
    end
  end
  inherited pgcDados: TPageControl
    Top = 65
    Width = 650
    Height = 366
    Visible = False
    ExplicitTop = 65
    ExplicitWidth = 650
    ExplicitHeight = 366
    inherited tbsGeral: TTabSheet
      ExplicitWidth = 642
      ExplicitHeight = 334
    end
  end
  object pnlCabecalho: TPanel [3]
    Left = 0
    Top = 0
    Width = 650
    Height = 65
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    ParentBackground = False
    TabOrder = 3
    object Label5: TLabel
      Left = 20
      Top = 14
      Width = 47
      Height = 14
      Alignment = taRightJustify
      Caption = 'Duplicata:'
    end
    object Label1: TLabel
      Left = 183
      Top = 14
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
    end
    object Label2: TLabel
      Left = 26
      Top = 37
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object Label3: TLabel
      Left = 193
      Top = 37
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
    end
    object edtNumDup: TEditFocus
      Tag = 99
      Left = 69
      Top = 10
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 6
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 6
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 230
      Top = 10
      Width = 65
      Height = 22
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
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 69
      Top = 33
      Width = 44
      Height = 22
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = -1
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtCodCli: TEditFocus
      Tag = 99
      Left = 230
      Top = 33
      Width = 65
      Height = 22
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      TabOrder = 4
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
    object edtParcel: TEditFocus
      Tag = 99
      Left = 139
      Top = 10
      Width = 30
      Height = 22
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
      Alignment = taLeftJustify
    end
    object edtNomCli: TEditFocus
      Left = 296
      Top = 33
      Width = 321
      Height = 22
      TabStop = False
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
      Alignment = taLeftJustify
    end
    object edtNomEmp: TEditFocus
      Left = 296
      Top = 10
      Width = 321
      Height = 22
      TabStop = False
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
      Alignment = taLeftJustify
    end
  end
  object pnlDados: TPanel [4]
    Left = 0
    Top = 65
    Width = 650
    Height = 366
    Align = alClient
    ParentBackground = False
    TabOrder = 4
    object dbgDuplicatas: TDBGridCitel
      Left = 1
      Top = 1
      Width = 648
      Height = 335
      Align = alClient
      DataSource = dtsDados
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = 14
      TitleFont.Name = 'Arial'
      TitleFont.Pitch = fpVariable
      TitleFont.Style = []
      OnDrawColumnCell = dbgDuplicatasDrawColumnCell
      OnKeyDown = dbgDuplicatasKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'CTR_NUMDUP'
          Title.Caption = 'Duplicata'
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_SEQBAI'
          Title.Caption = 'Seq.'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_ESPDOC'
          Title.Caption = 'Esp'#233'cie'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_CODEMP'
          Title.Caption = 'Empresa'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CTR_DTAREC'
          Title.Caption = 'Dt. Recebimento'
          Width = 110
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'CTR_VALREC'
          Title.Alignment = taCenter
          Title.Caption = 'Vr. Recebido'
          Width = 110
          Visible = True
        end>
    end
    object pnlBotoesEstorno: TPanel
      Left = 1
      Top = 336
      Width = 648
      Height = 29
      Align = alBottom
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = 16770261
      ParentBackground = False
      TabOrder = 1
      object btnConfirma: TBitBtnLocked
        Left = 4
        Top = 3
        Width = 147
        Height = 22
        Caption = '[ F10 ] Confirma Estorno'
        TabOrder = 0
        OnClick = btnConfirmaClick
      end
      object btnSairEst: TBitBtnLocked
        Left = 469
        Top = 3
        Width = 147
        Height = 22
        Caption = '[ ESC ] Sair'
        TabOrder = 1
        OnClick = btnSairEstClick
      end
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 352
    Top = 168
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 320
    Top = 168
  end
  object dtsDados: TDataSource
    DataSet = cdsDados
    Left = 384
    Top = 168
  end
  object cdsDados: TUniClientDataSet
    Aggregates = <>
    IndexFieldNames = 'PARDUP;CTR_SEQBAI'
    Params = <>
    ProviderName = 'cpvDados'
    Left = 416
    Top = 168
  end
  object cpvDados: TUniDataSetProvider
    DataSet = qryDados
    Left = 448
    Top = 168
  end
  object qryDados: TUniQuery
    Connection = frmModulo.Database
    ReadOnly = True
    Params = <>
    Left = 480
    Top = 168
  end
end
