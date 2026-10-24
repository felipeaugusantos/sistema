unit untExpCat42;

interface

uses

  AppEvnts,
  Menus, StdCtrls, EditFocus, Mask, MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  frxClass, frxDBSet, StrUtils, Math, BitBtnLockedIncrem, DirectoryEditFocus, untTypesSistema,
  ComCtrls, ShlObj, cxShellCommon, cxControls, cxContainer, cxShellListView,
  XMLDoc, CheckLst, ShellApi, MemDS, DBAccess, Provider, frxExportCSVTestabilidade, cxGraphics,
  cxLookAndFeels, cxLookAndFeelPainters, cxTextEdit, cxMaskEdit, cxButtonEdit, Datasnap.DBClient,
  untFuncoesSimples, cxProgressBar, FilenameEditFocus, untGravando, Vcl.DBCtrls, DBMemoFocus,
  untFrameDirectoryEditFocus,  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes,  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai,  cxEdit, DateUtils,
  Uni, Vcl.Samples.Gauges, ComboBoxFocus, untTDadosRegistraLogCat42, cxButtons,
  cxClasses;

type
  TfrmExpCat42 = class(TfrmPai)
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lbl3: TLabel;
    lblOperacao: TLabel;
    pgbProgresso: TProgressBar;
    pgcControle: TPageControl;
    tbsGeral: TTabSheet;
    tbsOpcoes: TTabSheet;
    btnConfirma: TBitBtn;
    Label1: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    edtVersaoLayout: TEditFocus;
    cmbFinalidade: TComboBoxFocus;
    chkEnviarIsentoParaInsEst: TCheckBox;
    edtPatExp: TDirectoryEditFocus;
    procedure edtCodEmpKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodEmpExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    arrEmpresa: TConsultasArray;
    dadosRegistraLogCat42: TDadosRegistraLogCat42;

    procedure pCarregaPeriodoMesAtual;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmExpCat42: TfrmExpCat42;

implementation

uses untFuncoes, untConsultas,
     untTExportacaoCat42, untTDadosAberturaExportacaoCat42;

{$R *.dfm}

procedure TfrmExpCat42.btnConfirmaClick(Sender: TObject);
  var
    abertura: TDadosAberturaExportacaoCat42;
    objExportacao: TExportacaoCat42;
    stlArquivo: TStringList;
begin

  If fEmptyStr(edtPatExp.Text) then
  begin
    fMensagem('Aviso', 'Pasta para exportação do arquivo não selecionada!', ['Ok']);
    exit;
  end;

  pnlInfo.Caption := 'Aguarde, gerando arquivo...';
  pgcControle.ActivePageIndex := 0;
  Screen.Cursor   := crHourGlass;
  btnConfirma.Enabled := False;

  abertura := TDadosAberturaExportacaoCat42.Create(StrToDate(mskDtaIni.Text), StrToDate(mskDtaFin.Text), edtCodEmp.Text);
  abertura.strFinalidade := Copy(cmbFinalidade.Items[cmbFinalidade.ItemIndex], 0, 2);

  {FS 12092019:0857 CAT42}
  {abertura.strMesAno := '01/' + FormatDateTime('YYYY', StrToDate(mskDtaIni.Text));}
  abertura.strMesAno := FormatDateTime('MM/YYYY', StrToDate(mskDtaIni.Text));

  abertura.progressoTela := pgbProgresso;
  abertura.strVersaoLayout := edtVersaoLayout.Text;
  abertura.lblOperacao := lblOperacao;
  abertura.strPath := edtPatExp.Text;
  abertura.blnEnviarIsentoParaInsEst:= chkEnviarIsentoParaInsEst.Checked;

  stlArquivo := TStringList.Create;
  objExportacao := TExportacaoCat42.Create(abertura, stlArquivo);
  try
    objExportacao.pGerarArquivo;

    if stlArquivo.Count > 2 then
    begin

      dadosRegistraLogCat42:= TDadosRegistraLogCat42.Create;
      try
        dadosRegistraLogCat42.pRegistraLogCat42PeriodoGeradoAq(FormatDateTime('MM/YYYY', StrToDate(mskDtaIni.Text)), edtCodEmp.Text);
      finally
        dadosRegistraLogCat42.Free;
      end;

      fMensagem('Aviso', 'Geração Concluída!', ['Ok'])
    end
    else
      fMensagem('Aviso', 'Não Existe Movimentação Parcial ou Total Gravadas na Base de Dados para Período Informado!', ['Ok']);

    btnConfirma.Enabled := True;
    Screen.Cursor := crDefault;
    pnlInfo.Caption := '';
    lblOperacao.Caption:= '';
    pgbProgresso.Position:= 0;
    btnConfirma.SetFocus;
  finally
    objExportacao.Free;
    stlArquivo.Free;
    abertura.Free;
  end;
end;

procedure TfrmExpCat42.edtCodEmpExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodEmp, edtNomEmp, arrEmpresa, nil, fRetNomeEmpresaSelec, 'da Empresa');
end;

procedure TfrmExpCat42.edtCodEmpKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if fPesqEmpresa(conEmpSimples, Self, edtCodEmp, edtNomEmp, nil, Key, arrEmpresa, True) then
    Self.SelectNext(ActiveControl, True, True);
end;

procedure TfrmExpCat42.FormShow(Sender: TObject);
begin
  pCarregaPeriodoMesAtual;

  pSetFocus(mskDtaIni);
  edtPatExp.Text := VS_strPatPad;
  edtCodEmp.Text := VS_strCodEmp;
  edtNomEmp.Text := fRetNomeEmpresaSelec(VS_strCodEmp);
end;

function TfrmExpCat42.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  if (Sender = mskDtaIni) or (Sender = mskDtaFin) then
  begin
    if fEmptyStr(fTiraCaracEspeciais(mskDtaIni.Text)) then
    begin
      fMensagem('', 'O campo Data Inicial deve ser preenchido!', ['&Ok']);
      Result := False;

      if (Sender = mskDtaFin) then
        Sender := mskDtaIni;
    end
    else
    begin
      mskDtaIni.Text := DateToStr(StrToDate(mskDtaIni.Text));

      if (Sender = mskDtaFin) then
      begin
        if fEmptyStr(fTiraCaracEspeciais(mskDtaFin.Text)) then
        begin
          fMensagem('', 'O campo Data Final deve ser preenchido!', ['&Ok']);
          Result := False;
        end
        else
        begin
          if StrToDate(mskDtaIni.Text) > StrToDate(mskDtaFin.Text) then
          begin
            fMensagem('','A data inicial deve ser menor que a data final!',['&Ok']);
            Result := False;
          end
          else
            mskDtaFin.Text := DateToStr(StrToDate(mskDtaFin.Text));
        end;
      end
    end;
  end;

  if (Sender = edtCodEmp) then
  begin
    If fEmptyStr(edtCodEmp.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'É necessário informar um código de empresa!', ['&Ok']);
      pSetFocus(edtCodEmp);
      Result := False;
    End;
  end;

  if not Result then
    pSetFocus(Sender);
end;

procedure TfrmExpCat42.pCarregaPeriodoMesAtual;
  var
    intDia, intMes, intAno: word;
begin
  DecodeDate(date, intAno, intMes, intDia);
  intDia := DaysInMonth(date);
  mskDtaIni.Text := DateToStr(EncodeDate(intAno, intMes, 1));
  mskDtaFin.Text := DateToStr(EncodeDate(intAno, intMes, intDia));
end;

end.
