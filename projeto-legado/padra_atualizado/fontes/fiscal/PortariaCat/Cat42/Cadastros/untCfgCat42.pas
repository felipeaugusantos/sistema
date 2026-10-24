unit untCfgCat42;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.AppEvnts,
  cxTextEdit, cxMaskEdit, cxButtonEdit, DirectoryEditFocus, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, EditFocus, DateUtils, untFuncoes, Uni,
  untTypesSistema, Vcl.Mask, MaskEditFocus, Vcl.Samples.Gauges, Vcl.ComCtrls,
  ComboBoxFocus, untTDadosRegistraLogCat42, frxClass, DB,
  frxExportCSVTestabilidade, Vcl.Menus, BitBtnLockedIncrem;

type
  TfrmCfgCat42 = class(TfrmPai)
    btnConfirma: TBitBtn;
    pnlCfgCat42: TPanel;
    Label272: TLabel;
    LabelCat42ComST: TLabel;
    cmbPrecoInvCat42: TComboBox;
    cmbPrecoInvCat42ComST: TComboBox;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    qryAux: TUniQuery;
    procedure pGeraConfiguracoesBancoDeDados(strCodEmp, strCodCfg, strCdCfAb,
      strUtiBlc, strPriori, strDescri, strRegNeg, strValCfg, strGruCfg: string;
      intNumHlp: Integer; dtaUltAlt: TDate; hraUltAlt: TTime;
      strLayout: string);
  protected

  public
    { Public declarations }
  end;

var
  frmCfgCat42: TfrmCfgCat42;

implementation

{$R *.dfm}

procedure TfrmCfgCat42.btnConfirmaClick(Sender: TObject);
begin
  try
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IntToStr(cmbPrecoInvCat42.ItemIndex) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "PRECO_INV_CAT42";');
    qryAux.SQL.Add('UPDATE CFGSPD SET SPD_VALCFG = "' + IntToStr(cmbPrecoInvCat42ComST.ItemIndex) + '" WHERE SPD_CODEMP = "' + VS_strCodEmp + '" AND SPD_CODCFG = "PRECO_INV_CAT42_COM_ST";');
    qryAux.ExecSQL;

    fMensagem('', 'Configurações Salvas com sucesso!', ['&Ok']);
  except
    On E: Exception Do
    begin
      FreeAndNil(qryAux);
      fMensagem('ATENÇÃO!', 'Ocorreu problemas na gravação das informações, ' + e.Message, ['&Ok']);
      pnlInfo.Caption := 'Ocorreu problemas na gravação das informações';
      Abort;
    end;
  end;
  pnlInfo.Caption := '';
end;

procedure TfrmCfgCat42.FormCreate(Sender: TObject);
begin
  inherited;
  qryAux := fCriaQuery(Self);

  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PRECO_INV_CAT42',
    'CFG_PISSTC',
    'H',
    '',
    'Preço Inventário sem ST CAT42 0=Compra líquido (PRECOM líquido) 1=Última Compra mais impostos líquido (IMPULT líquido) 2=Compra (PRECOM) 3=Última Compra mais impostos (IMPULT) 4=Última Compra sem impostos (PREULT)',
    '',
    '0',
    'CONFIGURACOES-12_SPED_SUB_APURACAO_ICMS_OPCOES', 0, Date, fTime(), 'S');

  pGeraConfiguracoesBancoDeDados(VS_strCodEmp, 'PRECO_INV_CAT42_COM_ST',
    'CFG_PICSTC',
    'H',
    '',
    'Preço Inventário com ST CAT42 0=Compra líquido (PRECOM líquido) 1=Última Compra mais impostos líquido (IMPULT líquido) 2=Compra (PRECOM) 3=Última Compra mais impostos (IMPULT) 4=Última Compra sem impostos (PREULT)',
    '',
    '0',
    'CONFIGURACOES-12_SPED_SUB_APURACAO_ICMS_OPCOES', 0, Date, fTime(), 'S');
end;


procedure TfrmCfgCat42.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryAux);
end;

procedure TfrmCfgCat42.FormShow(Sender: TObject);
begin
  inherited;
  cmbPrecoInvCat42.ItemIndex := StrToInt(fCfgSpd('PRECO_INV_CAT42'));
  cmbPrecoInvCat42ComST.ItemIndex := StrToInt(fCfgSpd('PRECO_INV_CAT42_COM_ST'));
end;

procedure TfrmCfgCat42.pGeraConfiguracoesBancoDeDados(strCodEmp, strCodCfg,
  strCdCfAb, strUtiBlc, strPriori, strDescri, strRegNeg, strValCfg,
  strGruCfg: string; intNumHlp: Integer; dtaUltAlt: TDate; hraUltAlt: TTime;
  strLayout: string);
var
  Hora, Min, Sec, MSec : Word;
  strHraUltAlt: string;
begin
  DecodeTime(fNow, Hora, Min, Sec, MSec);
  strHraUltAlt := FormatDateTime('hh:mm:ss', hraUltAlt) + ':' + FormatFloat('000', MSec);

  qryAux.Close;
  qryAux.SQL.Clear;
  qryAux.SQL.Add('SELECT SPD_CODCFG FROM CFGSPD WHERE SPD_CODEMP = :CODEMP AND SPD_CODCFG = :CODCFG;');
  qryAux.ParamByName('CODEMP').AsString := strCodEmp;
  qryAux.ParamByName('CODCFG').AsString := strCodCfg;
  qryAux.Open;
  if qryAux.IsEmpty then
  begin
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add( ' INSERT INTO CFGSPD ( ');
    qryAux.SQL.Add( '   SPD_CODEMP, ');
    qryAux.SQL.Add( '   SPD_CODCFG, ');
    qryAux.SQL.Add( '   SPD_CDCFAB, ');
    qryAux.SQL.Add( '   SPD_UTIBLC, ');
    qryAux.SQL.Add( '   SPD_PRIORI, ');
    qryAux.SQL.Add( '   SPD_DESCRI, ');
    qryAux.SQL.Add( '   SPD_REGNEG, ');
    qryAux.SQL.Add( '   SPD_VALCFG, ');
    qryAux.SQL.Add( '   SPD_GRUCFG, ');
    qryAux.SQL.Add( '   SPD_NUMHLP, ');
    qryAux.SQL.Add( '   SPD_ULTALT, ');
    qryAux.SQL.Add( '   SPD_CODGEN, ');
    qryAux.SQL.Add( '   SPD_LAYOUT ');
    qryAux.SQL.Add( ' ) ');
    qryAux.SQL.Add( ' VALUES ');
    qryAux.SQL.Add( '   ( ');
    qryAux.SQL.Add( '     :CODEMP, ');
    qryAux.SQL.Add( '     :CODCFG, ');
    qryAux.SQL.Add( '     :CDCFAB, ');
    qryAux.SQL.Add( '     :UTIBLC, ');
    qryAux.SQL.Add( '     :PRIORI, ');
    qryAux.SQL.Add( '     :DESCRI, ');
    qryAux.SQL.Add( '     :REGNEG, ');
    qryAux.SQL.Add( '     :VALCFG, ');
    qryAux.SQL.Add( '     :GRUCFG, ');
    qryAux.SQL.Add( '     :NUMHLP, ');
    qryAux.SQL.Add( '     :ULTALT, ');
    qryAux.SQL.Add( '     :CODGEN, ');
    qryAux.SQL.Add( '     :LAYOUT ');
    qryAux.SQL.Add( '   ) ');

    qryAux.ParamByName('CODEMP').AsString  := strCodEmp;
    qryAux.ParamByName('CODCFG').AsString  := strCodCfg;
    qryAux.ParamByName('CDCFAB').AsString  := strCdCfAb;
    qryAux.ParamByName('UTIBLC').AsString  := strUtiBlc;
    qryAux.ParamByName('PRIORI').AsString  := strPriori;
    qryAux.ParamByName('DESCRI').AsString  := strDescri;
    qryAux.ParamByName('REGNEG').AsString  := strRegNeg;
    qryAux.ParamByName('VALCFG').AsString  := strValCfg;
    qryAux.ParamByName('GRUCFG').AsString  := strGruCfg;
    qryAux.ParamByName('NUMHLP').AsInteger := intNumHlp;
    qryAux.ParamByName('ULTALT').AsDate    := dtaUltAlt;
    qryAux.ParamByName('CODGEN').AsString  := strHraUltAlt;
    qryAux.ParamByName('LAYOUT').AsString  := strLayout;
    qryAux.ExecSQL;
  end;

end;

end.
