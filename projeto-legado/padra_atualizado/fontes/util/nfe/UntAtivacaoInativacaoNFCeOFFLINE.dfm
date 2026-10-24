object FrmAtivacaoInativacaoNFCeOFFLINE: TFrmAtivacaoInativacaoNFCeOFFLINE
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 87
  ClientWidth = 249
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 249
    Height = 57
    Align = alClient
    TabOrder = 0
    object RdGrpCFG_USAOFF: TRadioGroup
      Left = 1
      Top = 1
      Width = 247
      Height = 55
      Align = alClient
      Caption = 'ATIVACAO E INATIVACAO DE NFCe OFF-LINE'
      Color = 16770261
      Columns = 2
      Items.Strings = (
        ' Ligado'
        'Desligado')
      ParentBackground = False
      ParentColor = False
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 57
    Width = 249
    Height = 30
    Align = alBottom
    Color = 16770261
    ParentBackground = False
    TabOrder = 1
    object btnConfirma: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 109
      Height = 22
      Caption = '[F10] &Gravar'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnConfirmaClick
    end
  end
end
