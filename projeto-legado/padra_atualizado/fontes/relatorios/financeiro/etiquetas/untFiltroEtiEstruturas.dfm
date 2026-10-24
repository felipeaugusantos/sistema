inherited frmFiltroEtiEstruturas: TfrmFiltroEtiEstruturas
  Left = 278
  Top = 387
  Width = 381
  Height = 180
  ActiveControl = edtDesIni
  BorderIcons = [biSystemMenu]
  Caption = ''
  Position = poScreenCenter
  ExplicitWidth = 381
  ExplicitHeight = 180
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 136
    Width = 375
    ExplicitTop = 136
    ExplicitWidth = 375
  end
  inherited pnlStatus: TPanel
    Top = 136
    Width = 375
    ExplicitTop = 136
    ExplicitWidth = 375
    inherited pnlNomeForm: TPanel
      Left = 204
      ExplicitLeft = 204
    end
    inherited pnlInfo: TPanel
      Width = 204
      ExplicitWidth = 204
    end
  end
  inherited pgcDados: TPageControl
    Width = 375
    Height = 136
    ExplicitWidth = 375
    ExplicitHeight = 136
    inherited tbsGeral: TTabSheet
      ExplicitLeft = 4
      ExplicitTop = 28
      ExplicitWidth = 367
      ExplicitHeight = 104
    end
  end
  object pnlFundo: TPanel [3]
    Left = 0
    Top = 0
    Width = 375
    Height = 136
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Color = 16770261
    TabOrder = 3
    object Label1: TLabel
      Left = 7
      Top = 12
      Width = 81
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Inicial:'
    end
    object Label2: TLabel
      Left = 11
      Top = 35
      Width = 77
      Height = 14
      Alignment = taRightJustify
      Caption = 'Descri'#231#227'o Final:'
    end
    object Label6: TLabel
      Left = 20
      Top = 58
      Width = 68
      Height = 14
      Alignment = taRightJustify
      Caption = 'Linha / Grupo:'
    end
    object Label10: TLabel
      Left = 18
      Top = 106
      Width = 70
      Height = 14
      Alignment = taRightJustify
      Caption = 'Qtd. Etiquetas:'
    end
    object edtDesIni: TEditFocus
      Tag = 99
      Left = 92
      Top = 8
      Width = 269
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtDesFin: TEditFocus
      Tag = 99
      Left = 92
      Top = 31
      Width = 269
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 50
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 0
      TipoTexto = ttAlfanumerico
    end
    object edtQtdEti: TEditFocus
      Tag = 99
      Left = 92
      Top = 102
      Width = 52
      Height = 22
      Alignment = taLeftJustify
      CharCase = ecUpperCase
      MaxLength = 3
      TabOrder = 4
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = True
      TamCampo = 3
      TipoTexto = ttNumerico
    end
    object edtLinGru: TMaskEditFocus
      Tag = 99
      Left = 92
      Top = 54
      Width = 50
      Height = 22
      EditMask = '999.999;0;_'
      MaxLength = 7
      TabOrder = 2
      Text = ''
      OnKeyPress = edtLinGruKeyPress
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      ValidaData = False
    end
    object edtDesGru: TEditFocus
      Left = 145
      Top = 54
      Width = 216
      Height = 22
      TabStop = False
      Alignment = taLeftJustify
      Color = 16768952
      Enabled = False
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
    object chkMosFil: TCheckBox
      Left = 92
      Top = 81
      Width = 261
      Height = 17
      Caption = 'Mostrar apenas registros que satisfazem o filtro'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
  end
end
