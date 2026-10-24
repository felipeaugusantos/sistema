inherited frmRelCtrLogAcompDuplic: TfrmRelCtrLogAcompDuplic
  Left = 281
  Top = 143
  Width = 800
  Height = 576
  ActiveControl = edtNumDoc
  BorderIcons = [biSystemMenu]
  Caption = 'Relat'#243'rio de Log de Acompanhamento das Duplicatas'
  ExplicitWidth = 800
  ExplicitHeight = 576
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 505
    Width = 792
    ExplicitTop = 505
    ExplicitWidth = 792
    inherited btnSair: TBitBtn
      Left = 711
      ExplicitLeft = 711
    end
    inherited btnMudaOrdem: TBitBtn
      Left = 10
      ExplicitLeft = 10
    end
    inherited btnPesquisar: TBitBtn
      Left = 130
      ExplicitLeft = 130
    end
  end
  inherited pnlStatus: TPanel
    Top = 533
    Width = 792
    ExplicitTop = 533
    ExplicitWidth = 792
    inherited pnlNomeForm: TPanel
      Left = 621
      ExplicitLeft = 621
    end
    inherited pnlInfo: TPanel
      Width = 621
      ExplicitWidth = 621
    end
  end
  inherited pnlHeader: TPanel
    Width = 792
    Height = 111
    ExplicitWidth = 792
    ExplicitHeight = 111
    object Label12: TLabel
      Left = 72
      Top = 36
      Width = 35
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cliente:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label1: TLabel
      Left = 62
      Top = 60
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Empresa:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label27: TLabel
      Left = 50
      Top = 12
      Width = 57
      Height = 14
      Alignment = taRightJustify
      Caption = 'Documento:'
    end
    object Label3: TLabel
      Left = 294
      Top = 12
      Width = 39
      Height = 14
      Alignment = taRightJustify
      Caption = 'Parcela:'
    end
    object Label4: TLabel
      Left = 55
      Top = 84
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Incial:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label5: TLabel
      Left = 200
      Top = 84
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 212
      Top = 12
      Width = 41
      Height = 14
      Alignment = taRightJustify
      Caption = 'Esp'#233'cie:'
    end
    object edtCodEmpresa: TEditFocus
      Tag = 99
      Left = 112
      Top = 56
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      ParentFont = False
      TabOrder = 5
      OnKeyPress = edtCodEmpresaKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtDesEmpresa: TEditFocus
      Left = 176
      Top = 56
      Width = 457
      Height = 22
      TabStop = False
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtCodCliente: TEditFocus
      Tag = 99
      Left = 112
      Top = 32
      Width = 62
      Height = 22
      CharCase = ecUpperCase
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 8
      ParentFont = False
      TabOrder = 3
      OnKeyPress = edtCodClienteKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
      Alignment = taLeftJustify
    end
    object edtNomCliente: TEditFocus
      Left = 176
      Top = 32
      Width = 457
      Height = 22
      TabStop = False
      Color = 16768952
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
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
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 112
      Top = 8
      Width = 90
      Height = 22
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 12
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 12
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
    object edtParcel: TEditFocus
      Tag = 99
      Left = 336
      Top = 8
      Width = 26
      Height = 22
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 1
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 1
      TipoTexto = ttAlfabetico
      Alignment = taLeftJustify
    end
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 112
      Top = 80
      Width = 73
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
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
      Left = 256
      Top = 80
      Width = 73
      Height = 22
      EditMask = '99/99/9999;1;_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      ParentFont = False
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object edtEspecie: TEditFocus
      Tag = 99
      Left = 256
      Top = 8
      Width = 33
      Height = 22
      CharCase = ecUpperCase
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 2
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 2
      TipoTexto = ttAlfanumerico
      Alignment = taLeftJustify
    end
  end
  inherited pnlTail: TPanel
    Top = 457
    Width = 792
    ExplicitTop = 457
    ExplicitWidth = 792
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 151
    Width = 792
    Height = 306
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
  end
  inherited pnlPesquisa: TPanel
    Top = 111
    Width = 792
    ExplicitTop = 111
    ExplicitWidth = 792
    inherited lblPesquisa: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited lblNomeCampo: TLabel
      Top = 13
      ExplicitTop = 13
    end
    inherited edtData: TMaskEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtNumero: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtString: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
    inherited edtValor: TEditFocus
      Top = 9
      ExplicitTop = 9
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 552
    Top = 248
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 400
    Top = 248
  end
  inherited qryConsulta: TUniQuery
    Left = 264
    Top = 248
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 296
    Top = 248
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 328
    Top = 248
  end
  inherited dtsConsulta: TDataSource
    Left = 360
    Top = 248
  end
end
