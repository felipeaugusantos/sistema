unit untPnlPesqCadRec;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, UniClientDataSet, ExtCtrls, Uni,
  DB, BitBtnLockedIncrem,untAdiantamentoCliente;

type
  TfrmPnlPesqCadRec = class(TForm)
    btnDupAgrup: TBitBtnLocked;
    btnConsultarAdiantamentos: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnDupAgrupClick(Sender: TObject);
    procedure btnConsultarAdiantamentosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cdsConsulta: TUniClientDataSet;
  end;

TfrmPnlPesqCadRecClass = Class Of TfrmPnlPesqCadRec;

var
  frmPnlPesqCadRec: TfrmPnlPesqCadRec;

implementation

uses untFuncoesSimples, untFuncoesAuxiliares;

{$R *.dfm}

procedure TfrmPnlPesqCadRec.btnConsultarAdiantamentosClick(Sender: TObject);
  Var
    qryAux : TUniQuery;
    strSQL : String;
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT                     ';
  strSQL := strSQL + '  ADT_NUMDOC              ';
  strSQL := strSQL + 'FROM                       ';
  strSQL := strSQL + '  ADTCLI                   ';
  strSQL := strSQL + 'WHERE ADT_CODCLI = :CODCLI ';
  strSQL := strSQL + '  AND ADT_SEQCON = :SEQCON ';
  strSQL := strSQL + '  AND ADT_CODEMP = :CODEMP ';

  qryAux := fCriaQuery();
  Try
    With qryAux Do
    Begin
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODCLI').AsString := cdsConsulta.FieldByName('CTR_CODCLI').AsString;
      ParamByName('SEQCON').AsString := fCampoTabela('CTR_SEQCON', 'CADREC', ['AUTOINCREM'], [cdsConsulta.FieldByName('AUTOINCREM').AsString], False);;
      ParamByName('CODEMP').AsString := cdsConsulta.FieldByName('CTR_CODEMP').AsString;
      Open;

      If Not isEmpty Then
        TAdiantamento.pConsultarAdiantamentos(strloginUsuarioLogado,
                                              qryAux.FieldByName('ADT_NUMDOC').AsString,
                                              cdsConsulta.FieldByName('CTR_CODEMP').AsString)
      Else
        fMensagem('ATENÇÃO!', 'Não há lançamentos para o documento selecionado!', ['&Ok']);
    End;
  Finally
    pFreeAndNil(qryAux);
  End;
end;

procedure TfrmPnlPesqCadRec.btnDupAgrupClick(Sender: TObject);
begin

  If (cdsConsulta.FieldByName('CTR_ESPDOC').AsString <> 'AG') Then
    Exit;

  pMostraDuplicatasAgrupadas(cdsConsulta.FieldByName('CTR_NUMDUP').AsString,
                             cdsConsulta.FieldByName('CTR_CODEMP').AsString,
                             cdsConsulta.FieldByName('CTR_CODCLI').AsString,
                             FALSE{nao veio pelo Resumo de Caixa});

end;

procedure TfrmPnlPesqCadRec.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_F9 : Begin
              btnDupAgrup.Click;
              Key := 0;
            End;
    VK_F6 : Begin
              btnConsultarAdiantamentos.Click;
              Key := 0;
            End;
  end;
end;

end.
