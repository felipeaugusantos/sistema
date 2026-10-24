inherited frmConsultaCadAutDinamicaGeral: TfrmConsultaCadAutDinamicaGeral
  Left = 158
  Top = 134
  Caption = 'Consulta - Autocolor'
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbgConsulta: TDBGridCitel
    Height = 314
  end
  inherited pnlBotoes: TPanel
    inherited Label2: TLabel
      Top = 8
      ExplicitTop = 8
    end
    inherited btnConfirma: TBitBtnLocked
      Top = 4
      Width = 82
      ExplicitTop = 4
      ExplicitWidth = 82
    end
    inherited btnSair: TBitBtnLocked
      Left = 680
      ExplicitLeft = 680
    end
  end
  inherited Panel1: TPanel
    inherited lblBuscarPor1: TLabel
      Left = 134
      Top = 8
      ExplicitLeft = 134
      ExplicitTop = 8
    end
    inherited lblChave1: TLabel
      Top = 8
      ExplicitTop = 8
    end
    inherited lblChave2: TLabel
      Top = 46
      ExplicitTop = 46
    end
    inherited lblBuscarPor2: TLabel
      Left = 134
      Top = 46
      ExplicitLeft = 134
      ExplicitTop = 46
    end
    inherited lblBuscarPor3: TLabel
      Left = 134
      ExplicitLeft = 134
    end
    inherited lblChave3: TLabel
      Top = 84
      ExplicitTop = 84
    end
    inherited edtFiltro2: TEdit
      Top = 60
      ExplicitTop = 60
    end
    inherited edtFiltro3: TEdit
      Left = 134
      Top = 98
      Width = 372
      ExplicitLeft = 134
      ExplicitTop = 98
      ExplicitWidth = 372
    end
    inherited btnExecutaTarefa: TBitBtnLocked
      Caption = '[ F4 ] Formula'#231#227'o'
      Visible = True
      OnClick = btnExecutaTarefaClick
    end
  end
  object Panel2: TPanel [4]
    Left = 0
    Top = 314
    Width = 780
    Height = 32
    Align = alBottom
    Color = 16770261
    TabOrder = 4
    object Label5: TLabel
      Left = 222
      Top = 9
      Width = 97
      Height = 13
      Caption = 'Pre'#231'o de Venda GL:'
      Visible = False
    end
    object Label4: TLabel
      Left = 22
      Top = 9
      Width = 96
      Height = 13
      Caption = 'Pre'#231'o de Venda LT:'
      Visible = False
    end
    object dbeVenGl: TDBEditFocus
      Left = 325
      Top = 5
      Width = 79
      Height = 21
      DataField = 'AUT_VENGL'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 1
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
    object dbeVenLt: TDBEditFocus
      Left = 125
      Top = 5
      Width = 79
      Height = 21
      DataField = 'AUT_VENLT'
      DataSource = dtsConsulta
      ReadOnly = True
      TabOrder = 0
      Visible = False
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TipoTexto = ttAlfanumerico
    end
  end
end
