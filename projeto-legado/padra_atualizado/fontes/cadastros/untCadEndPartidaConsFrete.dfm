inherited frmCadEndPartidaConsFrete: TfrmCadEndPartidaConsFrete
  Width = 762
  Height = 530
  Caption = 'Cadastro de Endere'#231'os de Partida para Consulta de Frete'
  OnCloseQuery = FormCloseQuery
  ExplicitWidth = 762
  ExplicitHeight = 530
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 161
    Width = 746
    ExplicitTop = 161
    ExplicitWidth = 746
    inherited FlwBotoes: TFlowPanel
      Width = 211
      ExplicitWidth = 211
    end
    inherited btnSair: TBitBtnLocked
      Left = 660
      ExplicitLeft = 660
    end
    inherited btnCancela: TBitBtnLocked
      Left = 359
      ExplicitLeft = 359
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 270
      ExplicitLeft = 270
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 180
      ExplicitLeft = 180
    end
    inherited btnGravar: TBitBtnLocked
      Left = 91
      ExplicitLeft = 91
    end
    inherited btnIncluir: TBitBtnLocked
      Left = 2
      ExplicitLeft = 2
    end
  end
  inherited pnlStatus: TPanel
    Top = 475
    Width = 746
    ExplicitTop = 475
    ExplicitWidth = 746
    inherited pnlNomeForm: TPanel
      Left = 575
      ExplicitLeft = 575
    end
    inherited pnlInfo: TPanel
      Width = 575
      ExplicitWidth = 575
    end
  end
  inherited pnlHeader: TPanel
    Width = 746
    Height = 121
    ExplicitWidth = 746
    ExplicitHeight = 121
    inherited lblInf: TLabel
      Left = 733
      Top = 41
      Anchors = [akTop, akRight]
      ExplicitLeft = 704
      ExplicitTop = 41
    end
    object lblCepEnd: TLabel [1]
      Left = 45
      Top = 45
      Width = 22
      Height = 14
      Alignment = taRightJustify
      Caption = 'CEP:'
    end
    object lblCidade: TLabel [2]
      Left = 167
      Top = 45
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Cidade:'
    end
    object lblEstado: TLabel [3]
      Left = 557
      Top = 45
      Width = 36
      Height = 14
      Alignment = taRightJustify
      Caption = 'Estado:'
    end
    object lblEndere: TLabel [4]
      Left = 18
      Top = 66
      Width = 49
      Height = 14
      Alignment = taRightJustify
      Caption = 'Endere'#231'o:'
    end
    object lblBairro: TLabel [5]
      Left = 35
      Top = 89
      Width = 32
      Height = 14
      Alignment = taRightJustify
      Caption = 'Bairro:'
    end
    object lblNumero: TLabel [6]
      Left = 554
      Top = 66
      Width = 40
      Height = 14
      Alignment = taRightJustify
      Caption = 'N'#250'mero:'
    end
    object lblDescri: TLabel [7]
      Left = 15
      Top = 20
      Width = 52
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o:'
    end
    object lblSituacao: TLabel [8]
      Left = 549
      Top = 20
      Width = 45
      Height = 14
      Alignment = taRightJustify
      Caption = 'Situa'#231#227'o:'
    end
    object lblAtivoInativo: TColorLabel [9]
      Left = 636
      Top = 20
      Width = 75
      Height = 14
      Caption = '(A)tivo (I)nativo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      CorDestaque = clRed
    end
    inherited pgcDados: TPageControl
      Left = 733
      Anchors = [akTop, akRight]
      ExplicitLeft = 733
      inherited tbsGeral: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 28
        ExplicitWidth = 57
        ExplicitHeight = 15
      end
    end
    object dbeDescri: TDBEditFocus
      Tag = 99
      Left = 70
      Top = 17
      Width = 474
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'END_DESCRI'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeSituac: TDBEditFocus
      Tag = 99
      Left = 597
      Top = 17
      Width = 35
      Height = 22
      CharCase = ecUpperCase
      DataField = 'END_SITUAC'
      DataSource = dtsConsulta
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentFont = False
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfabetico
    end
    object dbeCepEnd: TDBEditFocus
      Tag = 99
      Left = 70
      Top = 40
      Width = 92
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'END_C_E_P_'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttNumerico
    end
    object dbeCodCid: TDBEditFocus
      Tag = 99
      Left = 206
      Top = 40
      Width = 44
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'END_CODCID'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 4
      OnKeyPress = dbeCodCidKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TipoTexto = ttAlfanumerico
    end
    object dbeNomCid: TDBEditFocus
      Left = 251
      Top = 40
      Width = 293
      Height = 22
      TabStop = False
      Color = 16768952
      Ctl3D = True
      DataField = 'CID_NOMCID'
      DataSource = dtsConsulta
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 5
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEstado: TDBEditFocus
      Tag = 99
      Left = 597
      Top = 40
      Width = 46
      Height = 22
      TabStop = False
      Color = 16768952
      Ctl3D = True
      DataField = 'CID_ESTADO'
      DataSource = dtsConsulta
      Enabled = False
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      ReadOnly = True
      TabOrder = 6
      NormalColor = 16768952
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeEndere: TDBEditFocus
      Tag = 99
      Left = 70
      Top = 63
      Width = 474
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'END_ENDERE'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 7
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeNumero: TDBEditFocus
      Tag = 99
      Left = 597
      Top = 63
      Width = 105
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'END_NUMERO'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 8
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeBairro: TDBEditFocus
      Tag = 99
      Left = 70
      Top = 86
      Width = 474
      Height = 22
      CharCase = ecUpperCase
      Ctl3D = True
      DataField = 'END_BAIRRO'
      DataSource = dtsConsulta
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ParentCtl3D = False
      TabOrder = 9
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbckEndPad: TDBCheckBox
      Left = 597
      Top = 89
      Width = 105
      Height = 17
      Caption = 'Endere'#231'o padr'#227'o'
      DataField = 'END_ENDPAD'
      DataSource = dtsConsulta
      TabOrder = 10
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  inherited pnlTail: TPanel
    Top = 412
    Width = 746
    Height = 37
    Visible = True
    ExplicitTop = 412
    ExplicitWidth = 746
    ExplicitHeight = 37
    object btnConfirma: TBitBtnLocked
      Left = 8
      Top = 6
      Width = 105
      Height = 24
      Caption = '[ F10 ] Confirmar'
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 189
    Width = 746
    Height = 223
    Columns = <
      item
        Expanded = False
        FieldName = 'END_SITUAC'
        Title.Caption = 'Situa'#231#227'o'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'END_DESCRI'
        Title.Caption = 'Descri'#231#227'o'
        Width = 270
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'END_ENDERE'
        Title.Caption = 'Endere'#231'o'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CID_NOMCID'
        Title.Caption = 'Cidade'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'END_ENDPAD'
        Title.Caption = 'Padr'#227'o'
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 121
    Width = 746
    ExplicitTop = 121
    ExplicitWidth = 746
  end
  inherited pnlInfBotoes: TPanel
    Top = 449
    Width = 746
    Visible = False
    ExplicitTop = 449
    ExplicitWidth = 746
    inherited Label1: TLabel
      Width = 742
      Height = 22
    end
  end
  inherited cdsConsulta: TUniClientDataSet
    OnNewRecord = cdsConsultaNewRecord
  end
end
