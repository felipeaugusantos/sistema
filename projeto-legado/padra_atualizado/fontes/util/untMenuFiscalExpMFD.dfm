inherited frmMenuFiscalExpMFD: TfrmMenuFiscalExpMFD
  Width = 317
  Height = 202
  BorderStyle = bsNone
  Caption = ''
  ExplicitWidth = 317
  ExplicitHeight = 202
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 186
    Width = 317
    Height = 0
    Visible = False
    ExplicitTop = 186
    ExplicitWidth = 317
    ExplicitHeight = 0
    DesignSize = (
      317
      0)
    inherited btnSair: TBitBtnLocked
      Left = 228
      Top = -25
      ExplicitLeft = 228
      ExplicitTop = -25
    end
  end
  object pnlCabecalho: TPanel [2]
    Left = 0
    Top = 0
    Width = 317
    Height = 41
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
  end
  object pnlGeral: TPanel [3]
    Left = 0
    Top = 41
    Width = 317
    Height = 145
    Align = alClient
    TabOrder = 3
    object lblInformacoes: TLabel
      Left = 1
      Top = 130
      Width = 315
      Height = 14
      Align = alBottom
      Alignment = taCenter
      Caption = 'Informa'#231#245'es'
      WordWrap = True
      ExplicitTop = 178
      ExplicitWidth = 60
    end
    object rdgIntervalo: TRadioGroup
      Tag = 99
      Left = 8
      Top = 8
      Width = 121
      Height = 73
      Caption = 'Intervalo'
      ItemIndex = 0
      Items.Strings = (
        'Per'#237'odo'
        'Intervalo de COO')
      TabOrder = 0
      OnClick = rdgIntervaloClick
    end
    object gpbValores: TGroupBox
      Tag = 99
      Left = 136
      Top = 8
      Width = 165
      Height = 73
      Caption = 'Valores da Sele'#231#227'o'
      TabOrder = 1
      object lblFiltroIni: TLabel
        Left = 9
        Top = 24
        Width = 51
        Height = 14
        Caption = 'Data Inicial'
      end
      object lblFiltroFin: TLabel
        Left = 85
        Top = 24
        Width = 47
        Height = 14
        Caption = 'Data Final'
      end
      object mskFiltroIni: TMaskEditFocus
        Tag = 99
        Left = 6
        Top = 40
        Width = 69
        Height = 22
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 0
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
      object mskFiltroFin: TMaskEditFocus
        Tag = 99
        Left = 85
        Top = 40
        Width = 71
        Height = 22
        EditMask = '99/99/9999;1;_'
        MaxLength = 10
        TabOrder = 1
        Text = '  /  /    '
        NormalColor = clWindow
        FocusColor = clInfoBk
        RequeridoColor = clRed
        Requerido = False
        ValidaData = True
      end
    end
    object btnEmitir: TBitBtnLocked
      Left = 10
      Top = 89
      Width = 114
      Height = 22
      Caption = '&Emitir'
      TabOrder = 2
      OnClick = btnEmitirClick
    end
  end
  inherited pnlStatus: TPanel
    Top = 186
    Width = 317
    ExplicitTop = 186
    ExplicitWidth = 317
    inherited pnlNomeForm: TPanel
      Left = 146
      ExplicitLeft = 146
    end
    inherited pnlInfo: TPanel
      Width = 146
      ExplicitWidth = 146
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 264
    Top = 48
  end
end
