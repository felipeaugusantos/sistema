inherited frmCfgLocFis: TfrmCfgLocFis
  Left = 0
  Top = 0
  Width = 470
  Height = 272
  BorderIcons = [biSystemMenu]
  Caption = ' '
  Position = poMainFormCenter
  ExplicitWidth = 470
  ExplicitHeight = 272
  PixelsPerInch = 96
  TextHeight = 14
  object Label3: TLabel [0]
    Left = 7
    Top = 8
    Width = 97
    Height = 14
    Caption = 'Campos Dispon'#237'veis'
  end
  object Label4: TLabel [1]
    Left = 160
    Top = 10
    Width = 88
    Height = 14
    Caption = 'Campos Utilizados'
  end
  inherited pnlBotoes: TPanel
    Top = 200
    Width = 464
    TabOrder = 5
    ExplicitTop = 200
    ExplicitWidth = 464
    inherited btnSair: TBitBtnLocked
      Left = 385
      Top = 2
      Height = 24
      Align = alRight
      ExplicitLeft = 385
      ExplicitTop = 2
      ExplicitHeight = 24
    end
  end
  inherited pnlStatus: TPanel
    Top = 228
    Width = 464
    TabOrder = 6
    ExplicitTop = 228
    ExplicitWidth = 464
    inherited pnlNomeForm: TPanel
      Left = 293
      ExplicitLeft = 293
    end
    inherited pnlInfo: TPanel
      Width = 293
      ExplicitWidth = 293
    end
  end
  object lstCamDis: TListBox [5]
    Left = 7
    Top = 27
    Width = 109
    Height = 161
    ItemHeight = 14
    Items.Strings = (
      'Departamento'
      'Rua'
      'Pr'#233'dio'
      'Andar'
      'Apartamento')
    TabOrder = 0
    OnClick = lstCamDisClick
  end
  object lstCamCom: TListBox [6]
    Left = 160
    Top = 29
    Width = 109
    Height = 161
    DragMode = dmAutomatic
    ItemHeight = 14
    TabOrder = 1
    OnClick = lstCamDisClick
    OnDragDrop = lstCamComDragDrop
    OnDragOver = lstCamComDragOver
  end
  object btnAdicionar: TBitBtnLocked [7]
    Left = 122
    Top = 27
    Width = 32
    Height = 25
    Caption = '>>'
    Enabled = False
    TabOrder = 2
    OnClick = btnAdicionarClick
  end
  object btnRemover: TBitBtnLocked [8]
    Left = 122
    Top = 58
    Width = 32
    Height = 25
    Caption = '<<'
    Enabled = False
    TabOrder = 3
    OnClick = btnRemoverClick
  end
  object grbConfig: TGroupBox [9]
    Left = 275
    Top = 29
    Width = 174
    Height = 161
    Caption = '[Configura'#231#245'es]'
    TabOrder = 4
    OnExit = grbConfigExit
    object Label1: TLabel
      Left = 12
      Top = 64
      Width = 43
      Height = 14
      Caption = 'Tamanho'
    end
    object Label2: TLabel
      Left = 12
      Top = 18
      Width = 69
      Height = 14
      Caption = 'Tipo de Dados'
    end
    object spnTamCam: TSpinEdit
      Left = 12
      Top = 83
      Width = 69
      Height = 23
      MaxValue = 4
      MinValue = 1
      TabOrder = 1
      Value = 1
    end
    object cmbTipDad: TComboBox
      Left = 12
      Top = 36
      Width = 145
      Height = 22
      Style = csDropDownList
      TabOrder = 0
      OnChange = cmbTipDadChange
      Items.Strings = (
        'Alfa'
        'N'#250'merico'
        'Alfanumerico')
    end
    object chkAutCom: TCheckBox
      Left = 12
      Top = 111
      Width = 133
      Height = 17
      Caption = 'Completar com Zeros'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
end
