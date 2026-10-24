inherited frmCadManutInvFatorLote: TfrmCadManutInvFatorLote
  Left = 312
  Top = 467
  Width = 373
  Height = 388
  Caption = 'Reajuste de valores'
  Position = poMainFormCenter
  ExplicitWidth = 373
  ExplicitHeight = 388
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel [0]
    Left = 177
    Top = 241
    Width = 75
    Height = 14
    Caption = 'Fator de ajuste:'
  end
  object Label2: TLabel [1]
    Left = 135
    Top = 289
    Width = 116
    Height = 14
    Caption = 'Valor total do Invent'#225'rio:'
  end
  object lbl1: TLabel [2]
    Left = 6
    Top = 112
    Width = 109
    Height = 14
    Caption = 'Linha / Grupo a Excluir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel [3]
    Left = 60
    Top = 265
    Width = 192
    Height = 14
    Alignment = taRightJustify
    Caption = 'Valor do Invent'#225'rio com os filtros acima:'
  end
  inherited pnlBotoes: TPanel
    Top = 315
    Width = 367
    TabOrder = 8
    ExplicitTop = 315
    ExplicitWidth = 367
    inherited FlwBotoes: TFlowPanel
      Left = 174
      Width = 109
      TabOrder = 3
      ExplicitLeft = 174
      ExplicitTop = 2
      ExplicitWidth = 109
      ExplicitHeight = 24
    end
    inherited btnSair: TBitBtnLocked
      Left = 283
      Top = 2
      Width = 82
      Height = 24
      Align = alRight
      TabOrder = 2
      ExplicitLeft = 283
      ExplicitTop = 2
      ExplicitWidth = 82
      ExplicitHeight = 24
    end
    object btnAlterar: TBitBtnLocked
      Left = 84
      Top = 2
      Width = 90
      Height = 24
      Align = alLeft
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
      TabOrder = 1
      OnClick = btnAlterarClick
    end
    object btnCalcular: TBitBtnLocked
      Left = 2
      Top = 2
      Width = 82
      Height = 24
      Align = alLeft
      Caption = '[ F3 ] Calcular'
      TabOrder = 0
      OnClick = btnCalcularClick
    end
  end
  object rdgStatus: TRadioGroup [6]
    Left = 6
    Top = 70
    Width = 350
    Height = 40
    Caption = 'Status do Item'
    Columns = 3
    ItemIndex = 2
    Items.Strings = (
      'Ativo'
      'Inativo'
      'Todos')
    TabOrder = 1
    OnClick = rdgStatusClick
  end
  object rdgInfo: TRadioGroup [7]
    Left = 6
    Top = 2
    Width = 350
    Height = 67
    Caption = 'Informa'#231#227'o a alterar'
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      'Pre'#231'o de Custo'
      'Saldo de Estoque'
      'Ambos')
    TabOrder = 0
    WordWrap = True
    OnClick = rdgInfoClick
  end
  object edtFator: TEditFocus [8]
    Tag = 99
    Left = 256
    Top = 233
    Width = 100
    Height = 22
    Alignment = taRightJustify
    TabOrder = 5
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttNumerico
    EditFormat = '#,##0.0000'
  end
  object edtTotInv: TEditFocus [9]
    Left = 256
    Top = 281
    Width = 100
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    ReadOnly = True
    TabOrder = 7
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object mskLinGru: TMaskEditFocus [10]
    Left = 6
    Top = 127
    Width = 55
    Height = 22
    EditMask = '999.999;0;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = 14
    Font.Name = 'Arial'
    Font.Pitch = fpVariable
    Font.Style = []
    MaxLength = 7
    ParentFont = False
    TabOrder = 2
    Text = ''
    OnChange = mskLinGruChange
    OnExit = mskLinGruExit
    OnKeyPress = mskLinGruKeyPress
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    ValidaData = False
  end
  object edtDesGru: TEditFocus [11]
    Left = 65
    Top = 127
    Width = 291
    Height = 22
    TabStop = False
    Alignment = taLeftJustify
    Color = 16768952
    Enabled = False
    TabOrder = 9
    NormalColor = 16768952
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  object rdgSaldos: TRadioGroup [12]
    Left = 6
    Top = 155
    Width = 350
    Height = 40
    Caption = 'Saldo do Lote'
    Columns = 3
    ItemIndex = 2
    Items.Strings = (
      'Positivo'
      'Negativo'
      'Todos')
    TabOrder = 3
    OnClick = rdgStatusClick
  end
  object edtParInv: TEditFocus [13]
    Left = 256
    Top = 257
    Width = 100
    Height = 22
    TabStop = False
    Alignment = taRightJustify
    ReadOnly = True
    TabOrder = 6
    NormalColor = clWindow
    FocusColor = clInfoBk
    RequeridoColor = clRed
    Requerido = False
    CompZeros = False
    TamCampo = 0
    TipoTexto = ttAlfanumerico
  end
  inherited pnlStatus: TPanel
    Top = 343
    Width = 367
    TabOrder = 10
    ExplicitTop = 343
    ExplicitWidth = 367
    inherited pnlNomeForm: TPanel
      Left = 196
      ExplicitLeft = 196
    end
    inherited pnlInfo: TPanel
      Width = 196
      ExplicitWidth = 196
      object shpMultSel: TShape
        Left = 178
        Top = 2
        Width = 16
        Height = 12
        Hint = 'As consultas deste relat'#243'rio possuem multisele'#231#227'o'
        Align = alRight
        Brush.Color = clBlue
        ParentShowHint = False
        Pen.Style = psClear
        ShowHint = True
        ExplicitLeft = 182
        ExplicitTop = 1
        ExplicitHeight = 14
      end
    end
  end
  object chkArrendondarSaldo: TCheckBox [15]
    Left = 6
    Top = 204
    Width = 350
    Height = 25
    Caption = 
      'Arredondar quantidade considerando Item Fracionado do Cad.Unidad' +
      'es'
    TabOrder = 4
    Visible = False
    WordWrap = True
  end
  inherited mnuAuxiliar: TPopupMenu
    Top = 176
  end
  inherited ApplicationEvents: TApplicationEvents
    Left = 288
  end
  inherited frxCSVExportTestabilidade: TfrxCSVExportTestabilidade
    Left = 312
    Top = 96
  end
end
