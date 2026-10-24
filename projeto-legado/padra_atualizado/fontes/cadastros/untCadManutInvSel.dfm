inherited frmCadManutInvSel: TfrmCadManutInvSel
  Left = 355
  Top = 351
  Width = 219
  Height = 345
  Caption = 'Selecione o Arquivo para altera'#231#227'o'
  Position = poScreenCenter
  OnClose = FormClose
  OnDestroy = FormDestroy
  ExplicitWidth = 219
  ExplicitHeight = 345
  PixelsPerInch = 96
  TextHeight = 14
  inherited pnlBotoes: TPanel
    Top = 273
    Width = 213
    TabOrder = 2
    ExplicitTop = 273
    ExplicitWidth = 213
    DesignSize = (
      213
      28)
    inherited btnSair: TBitBtnLocked
      Left = 130
      ModalResult = 2
      ExplicitLeft = 130
    end
    object btnAlterar: TBitBtnLocked
      Left = 4
      Top = 3
      Width = 88
      Height = 22
      Caption = '[F10] &Alterar'
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
        A46769A46769A46769A46769A46769A46769A46769A46769A46769A46769A467
        69A46769A46769FF00FFFF00FFFF00FFA46769FEE9C7C6CC93D5CE96F2D0A0E7
        CA91E9C588EDC182EBC17FEBC180EBC180F2C782A46769FF00FFFF00FFFF00FF
        A46769FCEACE99C0772D98226FAC4E2091162191165FA139CAB770E9BD7FE9BD
        7FEFC481A46769FF00FFFF00FFFF00FFA0675BFEEFDABFCE99108C0D00820100
        820100820100820129921ADEBB7DE9BD7FEFC481A46769FF00FFFF00FFFF00FF
        A0675BFFF4E5BDD19F138F0F0082011B9114A9BD7573AB4D04840377A948EABF
        81EFC480A46769FF00FFFF00FFFF00FFA7756BFFFBF0BCD5A70A8A0A00820104
        860482B55FF0D0A9A5B76E6DAD4EEBC28AEFC583A46769FF00FFFF00FFFF00FF
        A7756BFFFFFCE1E7D0A4CC9099C68193C17799C077EED4AFF0D0A79FC279EBC7
        93F2C98CA46769FF00FFFF00FFFF00FFBC8268FFFFFFA7D9A4FAEFE6F4E9D59D
        C68495C17797BF759FBD75EACFA3EECC9EF3CE97A46769FF00FFFF00FFFF00FF
        BC8268FFFFFF74C575B0D8A9FAEFE684C1760586040082010A8909F3D4B0F0D0
        A6F6D3A0A46769FF00FFFF00FFFF00FFD1926DFFFFFF81CA820586057AC475AF
        D4A01C9518008201138E0FF3D9B8F4D8B1EBCFA4A46769FF00FFFF00FFFF00FF
        D1926DFFFFFFF3FAF32DA12D008201008201008201008201118E0FFBEACEDECE
        B4B6AA93A46769FF00FFFF00FFFF00FFDA9D75FFFFFFFFFFFFDDF2DD67BF6724
        9C2422992175BF6B2D9926956D56A56B5FA56B5FA46769FF00FFFF00FFFF00FF
        DA9D75FFFFFFFFFFFFFFFFFFFFFFFFE1F3E1E0F2DDFFFEF7ACB6928B6E51E19E
        55E68F31B56D4DFF00FFFF00FFFF00FFE7AB79FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFDCC7C5A56B5FF8B55CBF7A5CFF00FFFF00FFFF00FFFF00FF
        E7AB79FBF4F0FBF4EFFAF3EFFAF3EFF8F2EFF7F2EFF7F2EFD8C2C0A56B5FC183
        6CFF00FFFF00FFFF00FFFF00FFFF00FFE7AB79D1926DD1926DD1926DD1926DD1
        926DD1926DD1926DD1926DA56B5FFF00FFFF00FFFF00FFFF00FF}
      ModalResult = 1
      TabOrder = 1
    end
  end
  inherited pnlStatus: TPanel
    Top = 301
    Width = 213
    TabOrder = 3
    ExplicitTop = 301
    ExplicitWidth = 213
    inherited pnlNomeForm: TPanel
      Left = 42
      ExplicitLeft = 42
    end
    inherited pnlInfo: TPanel
      Width = 42
      ExplicitWidth = 42
    end
  end
  object pnlTipInv: TPanel [3]
    Left = 0
    Top = 0
    Width = 213
    Height = 61
    Align = alTop
    TabOrder = 0
    object rdgTipoArq: TRadioGroup
      Left = 8
      Top = 4
      Width = 193
      Height = 49
      Caption = 'Alterar Tabela'
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        'Invent'#225'rio'
        'Fiscal')
      TabOrder = 0
      OnClick = rdgTipoArqClick
    end
  end
  object Panel1: TPanel [4]
    Left = 0
    Top = 61
    Width = 213
    Height = 212
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 1
    object Label4: TLabel
      Left = 1
      Top = 1
      Width = 211
      Height = 14
      Align = alTop
      Alignment = taCenter
      Caption = 'Arquivo(s) de invent'#225'rio f'#237'sico'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ParentFont = False
      ExplicitWidth = 146
    end
    object lstArquivos: TCheckListBox
      Left = 1
      Top = 15
      Width = 211
      Height = 196
      OnClickCheck = lstArquivosClickCheck
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = 14
      Font.Name = 'Arial'
      Font.Pitch = fpVariable
      Font.Style = []
      ImeName = 'Portugu'#234's (Brasil ABNT)'
      ItemHeight = 14
      ParentFont = False
      TabOrder = 0
    end
  end
  inherited mnuAuxiliar: TPopupMenu
    Left = 344
    Top = 88
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 48
    Top = 128
  end
end
