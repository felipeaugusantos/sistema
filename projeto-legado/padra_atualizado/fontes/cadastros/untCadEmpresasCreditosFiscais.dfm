inherited frmCadEmpresasCreditosFiscais: TfrmCadEmpresasCreditosFiscais
  Height = 468
  Caption = 'Lan'#231'amento de cr'#233'ditos Fiscais'
  ExplicitHeight = 468
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 133
    ExplicitTop = 133
    inherited FlwBotoes: TFlowPanel
      Align = alLeft
      ExplicitWidth = 182
    end
    inherited btnCancela: TBitBtnLocked
      Left = 359
    end
    inherited btnExcluir: TBitBtnLocked
      Left = 270
      ExplicitLeft = 256
      ExplicitTop = 6
    end
    inherited btnAlterar: TBitBtnLocked
      Left = 180
    end
    inherited btnGravar: TBitBtnLocked
      Left = 91
      ExplicitLeft = 64
      ExplicitTop = 6
    end
    inherited btnIncluir: TBitBtnLocked
      Left = 2
      ExplicitLeft = -19
      ExplicitTop = 6
    end
  end
  inherited pnlHeader: TPanel
    Height = 93
    ExplicitHeight = 93
    inherited lblInf: TLabel
      Left = 664
      Top = 59
      ExplicitLeft = 664
      ExplicitTop = 59
    end
    object Label2: TLabel [1]
      Left = 8
      Top = 24
      Width = 91
      Height = 14
      Caption = 'M'#234's de refer'#234'ncia:'
    end
    object Label3: TLabel [2]
      Left = 8
      Top = 48
      Width = 91
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'ICMS:'
    end
    object Label4: TLabel [3]
      Left = 184
      Top = 48
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'IPI:'
    end
    object Label5: TLabel [4]
      Left = 32
      Top = 72
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'PIS:'
    end
    object Label6: TLabel [5]
      Left = 184
      Top = 72
      Width = 65
      Height = 14
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'COFINS:'
    end
    inherited pgcDados: TPageControl
      Left = 644
      ExplicitLeft = 644
      inherited tbsGeral: TTabSheet
        ExplicitLeft = 4
        ExplicitTop = 28
        ExplicitWidth = 57
        ExplicitHeight = 15
      end
    end
    object dbeMesRef: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 16
      Width = 78
      Height = 22
      DataField = 'CRE_MESREF'
      DataSource = dtsConsulta
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeIcmAnt: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 40
      Width = 78
      Height = 22
      DataField = 'CRE_ICMANT'
      DataSource = dtsConsulta
      TabOrder = 2
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeIpiAnt: TDBEditFocus
      Tag = 99
      Left = 256
      Top = 40
      Width = 78
      Height = 22
      DataField = 'CRE_IPIANT'
      DataSource = dtsConsulta
      TabOrder = 3
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbePisAnt: TDBEditFocus
      Tag = 99
      Left = 104
      Top = 64
      Width = 78
      Height = 22
      DataField = 'CRE_PISANT'
      DataSource = dtsConsulta
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeCofAnt: TDBEditFocus
      Tag = 99
      Left = 256
      Top = 64
      Width = 78
      Height = 22
      DataField = 'CRE_COFANT'
      DataSource = dtsConsulta
      TabOrder = 5
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
  inherited pnlTail: TPanel
    Top = 338
    ExplicitTop = 338
  end
  inherited dbgConsulta: TDBGridCitel
    Top = 161
    Height = 177
    Columns = <
      item
        Expanded = False
        FieldName = 'CRE_MESREF'
        Title.Caption = 'M'#234's refer'#234'ncia'
        Width = 87
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CRE_ICMANT'
        Title.Alignment = taRightJustify
        Title.Caption = 'ICMS'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CRE_IPIANT'
        Title.Alignment = taRightJustify
        Title.Caption = 'IPI'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CRE_PISANT'
        Title.Alignment = taRightJustify
        Title.Caption = 'PIS'
        Width = 100
        Visible = True
      end
      item
        Alignment = taRightJustify
        Expanded = False
        FieldName = 'CRE_COFANT'
        Title.Alignment = taRightJustify
        Title.Caption = 'COFINS'
        Width = 100
        Visible = True
      end>
  end
  inherited pnlPesquisa: TPanel
    Top = 93
    ExplicitTop = 93
  end
  inherited pnlInfBotoes: TPanel
    Top = 387
    ExplicitTop = 387
    inherited Label1: TLabel
      Width = 713
      Height = 22
      Caption = 
        '[F2] Posiciona sobre a grade de registros     [ F3 ] Ordenar reg' +
        'istros pr'#243'xima coluna    [ F5 ] Pesquisar registros'
      ExplicitWidth = 536
    end
  end
  inherited pnlStatus: TPanel
    Top = 413
    ExplicitTop = 413
  end
  inherited cdsConsulta: TUniClientDataSet
    AfterOpen = cdsConsultaAfterOpen
  end
end
