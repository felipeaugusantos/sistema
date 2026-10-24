inherited frmAltGlobCadCartoesAlt: TfrmAltGlobCadCartoesAlt
  Width = 562
  Height = 219
  Caption = 'Replicar'
  ExplicitWidth = 562
  ExplicitHeight = 219
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 148
    Width = 556
    TabOrder = 3
    ExplicitTop = 148
    ExplicitWidth = 556
    inherited FlwBotoes: TFlowPanel
      Width = 552
      ExplicitWidth = 552
      inherited btnConfirma: TBitBtnLocked
        Width = 96
        Caption = '[F10] &Gravar'
        ModalResult = 0
        ExplicitWidth = 96
      end
    end
    inherited btnSair: TBitBtnLocked
      Left = 454
      Width = 96
      ExplicitLeft = 454
      ExplicitWidth = 96
    end
  end
  inherited pnlStatus: TPanel
    Top = 174
    Width = 556
    TabOrder = 4
    ExplicitTop = 174
    ExplicitWidth = 556
    inherited pnlNomeForm: TPanel
      Left = 385
      ExplicitLeft = 385
    end
    inherited pnlInfo: TPanel
      Width = 385
      ExplicitWidth = 385
    end
  end
  object gbClisiTef: TGroupBox [2]
    Left = 8
    Top = 49
    Width = 266
    Height = 90
    Caption = 'Fiserv-CliSiTef'
    TabOrder = 1
    object Label1: TLabel
      Left = 15
      Top = 39
      Width = 91
      Height = 14
      Caption = 'C'#243'digo Operadora:'
    end
    object Label2: TLabel
      Left = 15
      Top = 63
      Width = 82
      Height = 14
      Caption = 'C'#243'digo Bandeira:'
    end
    object edtCAR_TFTRED: TEditFocus
      Left = 112
      Top = 36
      Width = 137
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtCAR_TFTBAN: TEditFocus
      Left = 112
      Top = 60
      Width = 137
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object chkClisiTef: TCheckBox
      Left = 15
      Top = 15
      Width = 186
      Height = 17
      TabStop = False
      Caption = 'Replicar campos Fiserv-CliSiTef?'
      TabOrder = 2
    end
  end
  object gbNcr: TGroupBox [3]
    Left = 280
    Top = 49
    Width = 266
    Height = 90
    Caption = 'Conex'#227'oTech-Scope'
    TabOrder = 2
    object Label4: TLabel
      Left = 16
      Top = 39
      Width = 91
      Height = 14
      Caption = 'C'#243'digo Operadora:'
    end
    object Label5: TLabel
      Left = 16
      Top = 63
      Width = 82
      Height = 14
      Caption = 'C'#243'digo Bandeira:'
    end
    object edtCAR_TFRED2: TEditFocus
      Left = 112
      Top = 36
      Width = 137
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 0
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object edtCAR_TFBAN2: TEditFocus
      Left = 112
      Top = 60
      Width = 137
      Height = 22
      Alignment = taLeftJustify
      MaxLength = 5
      TabOrder = 1
      NormalColor = clWindow
      FocusColor = clInfoBk
      RequeridoColor = clRed
      Requerido = False
      CompZeros = False
      TamCampo = 5
      TipoTexto = ttAlfanumerico
    end
    object chkNcr: TCheckBox
      Left = 16
      Top = 15
      Width = 201
      Height = 17
      TabStop = False
      Caption = 'Replicar campos Conex'#227'oTech-Scope?'
      TabOrder = 2
    end
  end
  object rdgCAR_STATUS: TcxRadioGroup [4]
    Left = 8
    Top = 7
    Caption = 'Ativo?'
    Properties.Columns = 2
    Properties.Items = <
      item
        Caption = 'N'#227'o'
        Value = 'N'
      end
      item
        Caption = 'Sim'
        Value = 'S'
      end>
    ItemIndex = 1
    TabOrder = 0
    Height = 39
    Width = 266
  end
end
