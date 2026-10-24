object frmAcesso: TfrmAcesso
  Left = 245
  Top = 108
  BorderStyle = bsDialog
  Caption = 'Acesso'
  ClientHeight = 205
  ClientWidth = 373
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 54
    Top = 45
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object Label2: TLabel
    Left = 48
    Top = 19
    Width = 36
    Height = 13
    Caption = 'Usu'#225'rio'
  end
  object Label3: TLabel
    Left = 55
    Top = 97
    Width = 29
    Height = 13
    Caption = 'Banco'
  end
  object Label4: TLabel
    Left = 44
    Top = 71
    Width = 40
    Height = 13
    Caption = 'Servidor'
  end
  object Label5: TLabel
    Left = 58
    Top = 123
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object edtSenha: TEdit
    Left = 90
    Top = 42
    Width = 250
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object OKBtn: TButton
    Left = 152
    Top = 159
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 5
  end
  object CancelBtn: TButton
    Left = 232
    Top = 159
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
  end
  object edtUsuario: TEdit
    Left = 90
    Top = 16
    Width = 250
    Height = 21
    TabOrder = 0
  end
  object edtBanco: TEdit
    Left = 90
    Top = 94
    Width = 250
    Height = 21
    TabOrder = 3
  end
  object edtServidor: TEdit
    Left = 90
    Top = 68
    Width = 250
    Height = 21
    TabOrder = 2
  end
  object edtPorta: TEdit
    Left = 90
    Top = 120
    Width = 100
    Height = 21
    TabOrder = 4
  end
end
