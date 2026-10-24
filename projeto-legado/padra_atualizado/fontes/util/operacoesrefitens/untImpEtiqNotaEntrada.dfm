inherited frmImpEtiqNotaEntrada: TfrmImpEtiqNotaEntrada
  Width = 800
  Height = 498
  Caption = 'Impress'#227'o de Etiquetas de Nota de Entrada'
  ExplicitWidth = 800
  ExplicitHeight = 498
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 415
    Width = 784
    ExplicitTop = 415
    ExplicitWidth = 784
    inherited FlwBotoes: TFlowPanel
      Width = 703
      FlowStyle = fsTopBottomRightLeft
      TabOrder = 1
      ExplicitWidth = 703
      inherited btnMudaOrdem: TBitBtnLocked
        Left = 585
        Height = 24
        TabOrder = 1
        ExplicitLeft = 585
        ExplicitHeight = 24
      end
      inherited btnPesquisar: TBitBtnLocked
        Left = 472
        Height = 24
        TabOrder = 0
        ExplicitLeft = 472
        ExplicitHeight = 24
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 705
      Top = 2
      Height = 24
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 705
      ExplicitTop = 2
      ExplicitHeight = 24
    end
    object btnItens: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 151
      Height = 24
      Caption = '[ ENTER ] Itens da Nota'
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
        5555555FFFFFFFFFF5555550000000000555557777777777F5555550FFFFFFFF
        0555557F5FFFF557F5555550F0000FFF0555557F77775557F5555550FFFFFFFF
        0555557F5FFFFFF7F5555550F000000F0555557F77777757F5555550FFFFFFFF
        0555557F5FFFFFF7F5555550F000000F0555557F77777757F5555550FFFFFFFF
        0555557F5FFF5557F5555550F000FFFF0555557F77755FF7F5555550FFFFF000
        0555557F5FF5777755555550F00FF0F05555557F77557F7555555550FFFFF005
        5555557FFFFF7755555555500000005555555577777775555555555555555555
        5555555555555555555555555555555555555555555555555555}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnItensClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 443
    Width = 784
    ExplicitTop = 443
    ExplicitWidth = 784
    inherited pnlNomeForm: TPanel
      Left = 613
      ExplicitLeft = 613
    end
    inherited pnlInfo: TPanel
      Width = 613
      ExplicitWidth = 613
    end
  end
  inherited pnlHeader: TPanel
    Width = 784
    Height = 121
    ExplicitWidth = 784
    ExplicitHeight = 121
    object Label4: TLabel
      Left = 19
      Top = 13
      Width = 57
      Height = 14
      Caption = 'Documento:'
    end
    object Label5: TLabel
      Left = 190
      Top = 13
      Width = 41
      Height = 14
      Caption = 'Esp'#233'cie:'
    end
    object Label6: TLabel
      Left = 366
      Top = 13
      Width = 28
      Height = 14
      Caption = 'S'#233'rie:'
    end
    object Label1: TLabel
      Left = 15
      Top = 37
      Width = 59
      Height = 14
      Alignment = taRightJustify
      Caption = 'Fornecedor:'
    end
    object lblCodEmp: TLabel
      Left = 31
      Top = 60
      Width = 45
      Height = 14
      Caption = 'Empresa:'
    end
    object Label2: TLabel
      Left = 18
      Top = 83
      Width = 54
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Inicial:'
    end
    object Label3: TLabel
      Left = 180
      Top = 84
      Width = 50
      Height = 14
      Alignment = taRightJustify
      Caption = 'Data Final:'
    end
    object edtNumDoc: TEditFocus
      Tag = 99
      Left = 79
      Top = 10
      Width = 83
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 12
      TabOrder = 0
      OnEnter = edtNumDocEnter
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 12
      TipoTexto = ttNumerico
    end
    object edtEspDoc: TEditFocus
      Tag = 99
      Left = 233
      Top = 10
      Width = 37
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 2
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfabetico
    end
    object edtSerie: TEditFocus
      Tag = 99
      Left = 396
      Top = 10
      Width = 50
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtCodFor: TEditFocus
      Tag = 99
      Left = 79
      Top = 33
      Width = 83
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      TabOrder = 3
      OnKeyPress = edtCodForKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 8
      TipoTexto = ttNumerico
    end
    object edtNomFor: TEditFocus
      Left = 164
      Top = 33
      Width = 282
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object edtCodEmp: TEditFocus
      Tag = 99
      Left = 79
      Top = 56
      Width = 83
      Height = 22
      Alignment = taLeftJustify
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 3
      TabOrder = 5
      OnKeyPress = edtCodEmpKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtNomEmp: TEditFocus
      Left = 164
      Top = 56
      Width = 282
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
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
    object mskDtaIni: TMaskEditFocus
      Tag = 99
      Left = 79
      Top = 79
      Width = 83
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
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
      Left = 233
      Top = 79
      Width = 83
      Height = 22
      EditMask = '99/99/9999'
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      MaxLength = 10
      TabOrder = 8
      Text = '  /  /    '
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = True
    end
    object chkImpNot: TCheckBox
      Left = 322
      Top = 81
      Width = 123
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Imprime N'#250'mero Nota'
      TabOrder = 9
    end
    object chkImpGrp: TCheckBox
      Left = 136
      Top = 101
      Width = 309
      Height = 18
      Alignment = taLeftJustify
      Caption = 'Imprimir etiquetas de produtos do mesmo Grupo de Pre'#231'os?'
      TabOrder = 10
    end
  end
  inherited pnlTail: TPanel
    Top = 367
    Width = 784
    ExplicitTop = 367
    ExplicitWidth = 784
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 161
    Width = 784
    Height = 206
    Columns = <
      item
        Expanded = False
        FieldName = 'GER_DTAENT'
        Title.Caption = 'Data de Entrada'
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_NUMDOC'
        Title.Caption = 'Documento'
        Width = 79
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_ESPDOC'
        Title.Caption = 'Esp'#233'cie'
        Width = 44
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_SERIE_'
        Title.Caption = 'S'#233'rie'
        Width = 29
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODEMP'
        Title.Caption = 'Empresa'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GER_CODFOR'
        Title.Caption = 'Fornecedor'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FOR_NOMFOR'
        Title.Caption = 'Nome do Fornecedor'
        Width = 420
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 121
    Width = 784
    ExplicitTop = 105
    ExplicitWidth = 784
    inherited edtNumero: TEditFocus
      Width = 75
      ExplicitWidth = 75
    end
    inherited edtString: TEditFocus
      Left = 309
      ExplicitLeft = 309
    end
    inherited edtValor: TEditFocus
      Left = 637
      ExplicitLeft = 637
    end
  end
  inherited qryConsulta: TUniQuery
    Left = 656
    Top = 48
  end
  inherited dspConsulta: TUniDataSetProvider
    Left = 576
    Top = 56
  end
  inherited cdsConsulta: TUniClientDataSet
    Left = 528
    Top = 56
  end
  inherited dtsConsulta: TDataSource
    Left = 472
    Top = 56
  end
end
